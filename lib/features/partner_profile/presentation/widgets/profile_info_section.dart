import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hh/features/auth/logic/auth_provider.dart';
import 'package:flutter_hh/features/profile/logic/firestore_service.dart';
import 'package:flutter_hh/features/profile/models/user_model.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final instagramController = TextEditingController();
  String gender = 'Male';
  String orientation = 'Straight';
  final List<String> selectedInterests = [];
  final List<String> interestsOptions = [
    "Music", "Travel", "Fitness", "Gaming", "Cooking", "Movies", "Books", "Art",
  ];

  final picker = ImagePicker();
  File? _imageFile;
  bool isLoading = false;

  Future<void> saveProfile() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final uid = authProvider.user?.uid;
    if (uid == null) return;

    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim()) ?? 0;
    final instagram = instagramController.text.trim();

    if (name.isEmpty || age <= 0) return;

    setState(() => isLoading = true);

    String? imagePath = _imageFile?.path;

    final user = UserModel(
      uid: uid,
      name: name,
      gender: gender,
      orientation: orientation,
      age: age,
      interests: selectedInterests,
      instagram: instagram,
      imagePath: imagePath,
    );

    await FirestoreService().saveUserData(user);
    setState(() => isLoading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Info")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    _imageFile = File(picked.path);
                  });
                }
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null ? const Icon(Icons.camera_alt, size: 30) : null,
              ),
            ),
            const SizedBox(height: 24),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(labelText: "Gender"),
              items: ['Male', 'Female', 'Other']
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) => setState(() => gender = val!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: orientation,
              decoration: const InputDecoration(labelText: "Orientation"),
              items: ['Straight', 'Gay', 'Bisexual']
                  .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                  .toList(),
              onChanged: (val) => setState(() => orientation = val!),
            ),
            const SizedBox(height: 16),
            TextField(controller: ageController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Age")),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: interestsOptions.map((i) {
                final selected = selectedInterests.contains(i);
                return FilterChip(
                  label: Text(i),
                  selected: selected,
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        selectedInterests.add(i);
                      } else {
                        selectedInterests.remove(i);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(controller: instagramController, decoration: const InputDecoration(labelText: "Instagram")),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: saveProfile,
                    child: const Text("Save and Continue"),
                  ),
          ],
        ),
      ),
    );
  }
}