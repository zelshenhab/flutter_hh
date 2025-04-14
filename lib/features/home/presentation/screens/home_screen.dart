import 'package:flutter/material.dart';
import 'package:flutter_hh/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:flutter_hh/features/home/logic/home_provider.dart';
import 'package:flutter_hh/features/hunting_mode/presentation/screens/hunting_screen.dart';
import 'package:flutter_hh/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_hh/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<HomeProvider>(context).currentIndex;

    final List<Widget> pages = [
      HuntingScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
      const SubscriptionScreen(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
