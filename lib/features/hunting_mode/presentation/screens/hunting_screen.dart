import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hh/features/hunting_mode/logic/hunting_provider.dart';
import 'package:flutter_hh/features/partner_profile/presentation/screens/partner_profile_screen.dart';

class HuntingScreen extends StatefulWidget {
  const HuntingScreen({super.key});

  @override
  State<HuntingScreen> createState() => _HuntingScreenState();
}

class _HuntingScreenState extends State<HuntingScreen> {
  @override
  void initState() {
    super.initState();
    // تأخير استدعاء loadPartners إلى بعد البناء
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HuntingProvider>(context, listen: false).loadPartners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HuntingProvider>(context);
    final partners = provider.filteredPartners;

    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Partners")),
      body: Column(
        children: [
          // ✅ فلتر الجنس
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              value: provider.selectedGender,
              decoration: const InputDecoration(labelText: "Filter by Gender"),
              items:
                  ["All", "Male", "Female"]
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.setGenderFilter(value);
                }
              },
            ),
          ),

          // ✅ قائمة الشركاء
          Expanded(
            child:
                provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: partners.length,
                      itemBuilder: (context, index) {
                        final partner = partners[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading:
                                partner.imagePath != null
                                    ? CircleAvatar(
                                      backgroundImage: FileImage(
                                        File(partner.imagePath!),
                                      ),
                                    )
                                    : const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                            title: Text(partner.name),
                            subtitle: Text(
                              "Age: ${partner.age} • Interests: ${partner.interests.join(", ")}",
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => PartnerProfileScreen(
                                        partner: partner,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
