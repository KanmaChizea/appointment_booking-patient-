import 'package:flutter/material.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/widgets/appointment_list.dart';
import '../widgets/filter.dart';
import '../widgets/search.dart';

class MobileDashboard extends StatelessWidget {
  const MobileDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              FilterButton(),
              SizedBox(width: 12),
              Expanded(flex: 2, child: SearchField()),
            ],
          ),
          const AppointmentList()
        ],
      ),
    );
  }
}
