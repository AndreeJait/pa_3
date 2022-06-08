import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigatorModel {
  FaIcon icon;

  String initial;

  String name;

  bool isActive = false;

  BottomNavigatorModel(
      {required this.name, required this.initial, required this.icon});

  void checkCurrent(String currentName) {
    if (initial == currentName.split("_")[0]) {
      isActive = true;
      icon = FaIcon(
        icon.icon,
        size: icon.size,
        color: Colors.black87,
      );
    } else {
      isActive = false;
      icon = FaIcon(
        icon.icon,
        size: icon.size,
        color: Colors.black26,
      );
    }
  }
}
