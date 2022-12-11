import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/cubit/appointment_cubit.dart';
import '../widgets/appbar.dart';
import 'mobile.dart';
import '../../../responsive.dart';

import 'web.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AppointmentCubit>().clearAppointment(),
      child: Scaffold(
        body: Column(children: [
          const SizedBox(height: 8),
          const CustomAppbar(),
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
      ),
    );
  }
}
