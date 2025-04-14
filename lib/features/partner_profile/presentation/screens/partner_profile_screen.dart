import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hh/features/chat/presentation/screens/chat_room_screen.dart';
import 'package:flutter_hh/features/partner_profile/logic/partner_provider.dart';
import 'package:flutter_hh/features/profile/models/user_model.dart';
import 'package:provider/provider.dart';

class PartnerProfileScreen extends StatelessWidget {
  final UserModel partner;

  const PartnerProfileScreen({super.key, required this.partner});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PartnerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("${partner.name}'s Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    partner.imagePath != null
                        ? FileImage(File(partner.imagePath!))
                        : null,
                child:
                    partner.imagePath == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
              ),
            ),
            const SizedBox(height: 20),
            Text("Name: ${partner.name}", style: const TextStyle(fontSize: 18)),
            Text("Age: ${partner.age}", style: const TextStyle(fontSize: 18)),
            Text(
              "Gender: ${partner.gender}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Orientation: ${partner.orientation}",
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
                  partner.interests.map((i) => Chip(label: Text(i))).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              "Instagram: @${partner.instagram}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: const Text("Chat"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatRoomScreen(username: partner.name),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              icon: const Icon(Icons.block, color: Colors.red),
              label: const Text("Block", style: TextStyle(color: Colors.red)),
              onPressed: () {
                provider.blockUser(partner.name);
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.report, color: Colors.orange),
              label: const Text(
                "Report",
                style: TextStyle(color: Colors.orange),
              ),
              onPressed: () {
                provider.reportUser(partner.name, "Inappropriate behavior");
              },
            ),
          ],
        ),
      ),
    );
  }
}
