import 'package:flutter/material.dart';
import 'package:flutter_hh/features/profile/models/user_model.dart';
import 'package:flutter_hh/features/profile/logic/firestore_service.dart';

class HuntingProvider with ChangeNotifier {
  List<UserModel> _allPartners = [];
  List<UserModel> filteredPartners = [];
  bool isLoading = false;
  String selectedGender = "All";

  Future<void> loadPartners() async {
    isLoading = true;
    notifyListeners();

    _allPartners = await FirestoreService().getAllUsers();
    applyFilter(); // تطبق الفلترة مباشرة
  }

  void applyFilter() {
    if (selectedGender == "All") {
      filteredPartners = _allPartners;
    } else {
      filteredPartners = _allPartners.where((user) => user.gender == selectedGender).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void setGenderFilter(String gender) {
    selectedGender = gender;
    applyFilter();
  }
}
