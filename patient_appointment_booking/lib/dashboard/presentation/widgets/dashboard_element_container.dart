import 'package:flutter/material.dart';

import '../../data/models/dashboard_element.dart';

class DashboardElementContainer extends StatelessWidget {
  const DashboardElementContainer({
    Key? key,
    required this.dashboardElement,
  }) : super(key: key);

  final DashboardElement dashboardElement;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration:
          BoxDecoration(border: Border.all(width: 2, color: Colors.purple)),
      child: Column(
        children: [
          Icon(dashboardElement.icon, color: Colors.purple, size: 64),
          const SizedBox(height: 32),
          Text(dashboardElement.title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Text(dashboardElement.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => dashboardElement.route)),
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                side: const BorderSide(width: 2, color: Colors.purple)),
            child: Text(dashboardElement.buttonText),
          ),
        ],
      ),
    );
  }
}
