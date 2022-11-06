import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppbar(context: context),
    );
  }
}
