import 'package:flutter/material.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/screens/dashboard.dart';
import 'package:patient_appointment_booking_admin/responsive.dart';

import '../widgets/details.dart';

class MobileDetails extends StatelessWidget {
  const MobileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            body: const SingleChildScrollView(
                padding: EdgeInsets.all(16), child: Details()),
          )
        : const Dashboard();
  }
}
