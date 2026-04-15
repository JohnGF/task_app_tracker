import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String _role = 'kid'; // 'kid' or 'adult'
  int _points = 0;

  String get role => _role;
  int get points => _points;

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
  }

  void spendPoints(int amount) {
    if (_points >= amount) {
      _points -= amount;
      notifyListeners();
    }
  }
}
