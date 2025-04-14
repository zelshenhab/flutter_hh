import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/onboarding_page.dart';
import '../../logic/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final List<Map<String, String>> onboardingData = const [
    {
      "image": "assets/images/Frame 465.png",
      "title": "Find Your Match",
      "desc": "Discover partners nearby who share your interests.",
    },
    {
      "image": "assets/images/create.png",
      "title": "Stay Anonymous",
      "desc": "Enter hunting mode and meet people temporarily.",
    },
    {
      "image": "assets/images/login.png",
      "title": "Chat and Connect",
      "desc": "Send messages, voice notes, and share photos securely.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: provider.setPage,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final page = onboardingData[index];
                return OnboardingPage(
                  imagePath: page["image"]!,
                  title: page["title"]!,
                  description: page["desc"]!,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => Container(
                margin: const EdgeInsets.all(4),
                width: provider.currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      provider.currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/register');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("CONTINUE"),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
