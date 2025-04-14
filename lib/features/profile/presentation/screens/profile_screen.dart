import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hh/features/auth/logic/auth_provider.dart';
import 'package:flutter_hh/features/profile/logic/firestore_service.dart';
import 'package:flutter_hh/features/profile/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  bool isLoading = true;

  Future<void> loadUserData() async {
    final uid = Provider.of<AuthProvider>(context, listen: false).user?.uid;
    if (uid != null) {
      user = await FirestoreService().getUserData(uid);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : user == null
              ? const Center(child: Text("No data found."))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (user!.imagePath != null)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(user!.imagePath!)),
                      )
                    else
                      const CircleAvatar(radius: 50, child: Icon(Icons.person)),
                    const SizedBox(height: 16),
                    Text(
                      "Name: ${user!.name}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Age: ${user!.age}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Gender: ${user!.gender}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Orientation: ${user!.orientation}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Interests:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children:
                          user!.interests
                              .map((i) => Chip(label: Text(i)))
                              .toList(),
                    ),
                    const SizedBox(height: 12),
                    Text("Instagram: @${user!.instagram}"),
                    const SizedBox(height: 30),

                    // ✅ زر تسجيل الخروج
                    ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () async {
                        await Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).logout();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}
