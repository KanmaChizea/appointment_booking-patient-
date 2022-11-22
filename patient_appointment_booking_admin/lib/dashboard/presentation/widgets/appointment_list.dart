import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/cubit/selected_cubit.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/cubit/user_cubit.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/screens/mobile_details.dart';
import 'package:patient_appointment_booking_admin/responsive.dart';

import '../../domain/entity/appontments.dart';
import '../cubit/appointment_cubit.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, List<AppointmentEntity>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          return Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context
                        .read<UserCubit>()
                        .getUserData(state[index].patientId);
                    context.read<SelectedCubit>().select(state[index]);
                    if (Responsive.isMobile(context)) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MobileDetails()));
                    }
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title: Text(state[index].id!.substring(0, 10).toUpperCase()),
                  minLeadingWidth: 0,
                  leading: Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state[index].status ? Colors.green : Colors.red),
                  ),
                );
              },
              itemCount: state.length,
            ),
          );
        }
        return const Center(
            child: Padding(
          padding: EdgeInsets.only(top: 32.0),
          child: Text('No appointments were made for today'),
        ));
      },
    );
  }
}
