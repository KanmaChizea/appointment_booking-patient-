import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppbar(context: context),
    );
  }
}
