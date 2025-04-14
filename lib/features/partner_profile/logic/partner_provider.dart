import 'package:flutter/material.dart';

class PartnerProvider with ChangeNotifier {
  final List<String> blockedPartners = [];

  void blockUser(String username) {
    blockedPartners.add(username);
    notifyListeners();
  }

  void reportUser(String username, String reason) {
    // Send report to backend or Firebase
    debugPrint("User $username reported for: $reason");
  }
}
