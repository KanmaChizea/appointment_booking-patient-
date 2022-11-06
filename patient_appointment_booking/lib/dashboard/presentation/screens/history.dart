import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppbar(context: context),
    );
  }
}
