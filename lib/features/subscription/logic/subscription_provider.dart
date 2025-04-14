import 'package:flutter/material.dart';

class SubscriptionProvider with ChangeNotifier {
  bool isSubscribed = false;
  String selectedPlan = "Monthly";

  void selectPlan(String plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  void subscribe() {
    isSubscribed = true;
    notifyListeners();
  }

  void cancelSubscription() {
    isSubscribed = false;
    notifyListeners();
  }
}
