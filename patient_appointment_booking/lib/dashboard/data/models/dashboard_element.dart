import 'package:flutter/material.dart';

class DashboardElement {
  final String title;
  final IconData icon;
  final String subtitle;
  final String buttonText;
  final Widget route;
  DashboardElement({
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.buttonText,
    required this.route,
  });
}
