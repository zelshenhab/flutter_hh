import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String name = "John Doe";
  String gender = "Male";
  int age = 25;
  String instagram = "@john";
  List<String> interests = ["Music", "Travel"];
  bool isHunting = false;

  void toggleHunting() {
    isHunting = !isHunting;
    notifyListeners();
  }

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  // تقدر تضيف باقي التعديلات بنفس الطريقة
}

