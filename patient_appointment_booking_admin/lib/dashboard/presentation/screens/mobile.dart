import 'package:flutter/material.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/widgets/filter.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/widgets/search.dart';

class MobileDashboard extends StatelessWidget {
  const MobileDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              FilterButton(),
              SizedBox(width: 12),
              Expanded(flex: 2, child: SearchField())
            ],
          )
        ],
      ),
    );
  }
}
