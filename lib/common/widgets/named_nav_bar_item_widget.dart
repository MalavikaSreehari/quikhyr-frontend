import 'package:flutter/material.dart';

enum LabelPosition { right, left }

class NamedNavigationBarItemWidget extends BottomNavigationBarItem {
  final String initialLocation;

  NamedNavigationBarItemWidget({required Widget activeIcon, required Widget icon, String? label, required this.initialLocation,}) : super(icon: icon, label: label, activeIcon: activeIcon);

}
