import 'package:flutter/material.dart';
import 'package:flutter_hh/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return BottomNavigationBar(
      currentIndex: provider.currentIndex,
      onTap: provider.changeTab,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.blue,
      backgroundColor: Colors.black,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Hunt"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Messages"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Subscribe"),
      ],
    );
  }
}
