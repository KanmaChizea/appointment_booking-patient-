import 'package:flutter/material.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/widgets/details.dart';

import '../widgets/appointment_list.dart';
import '../widgets/filter.dart';
import '../widgets/search.dart';

class WebDashboard extends StatelessWidget {
  const WebDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SearchField(),
                  SizedBox(height: 8),
                  FilterButton(),
                  AppointmentList()
                ],
              ),
            )),
        Container(
            height: MediaQuery.of(context).size.height * 0.82,
            width: 1,
            color: Colors.grey),
        const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Details(),
            ))
      ],
    );
  }
}
