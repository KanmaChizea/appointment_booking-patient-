import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/screens/mobile.dart';
import 'package:patient_appointment_booking_admin/responsive.dart';

import 'web.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 24),
        Text('UNIVERSITY OF BENIN HEALTH CENTER APPOINTMENTS',
            textAlign: TextAlign.center,
            style: Responsive.isMobile(context)
                ? Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold)
                : Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (context, _) {
          if (Responsive.isMobile(context)) {
            return const MobileDashboard();
          } else if (Responsive.isTablet(context)) {
            return const WebDashboard();
          } else {
            return const WebDashboard();
          }
        })
      ]),
    );
  }
}
