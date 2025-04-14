import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Or continue with"),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIconButton("Google", Icons.g_mobiledata, Colors.red),
            _buildIconButton("Apple", Icons.apple, Colors.black),
            _buildIconButton("Facebook", Icons.facebook, Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(String label, IconData icon, Color color) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
    );
  }
}
