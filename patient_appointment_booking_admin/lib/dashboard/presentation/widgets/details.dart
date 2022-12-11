import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/cubit/appointment_cubit.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/cubit/user_cubit.dart';
import 'package:patient_appointment_booking_admin/responsive.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Responsive.isMobile(context)
            ? null
            : MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            image: Responsive.isMobile(context)
                ? null
                : const DecorationImage(
                    image: AssetImage(
                      'hospital.png',
                    ),
                    fit: BoxFit.contain)),
        child: const AppointmentDetails());
  }
}

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    return BlocBuilder<AppointmentCubit, AppointmentCubitState>(
        builder: (context, state) {
      if (state.selected != 0) {
        final selected = state.selected - 1;
        final appointment = state.appointmentList[selected];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ID',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            Text(
              appointment.patientId,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text('PATIENT NAME',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text('DEPARTMENT',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            Text(
              user.department,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text('FACULTY',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            Text(
              user.faculty,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            const Text('APPOINTMENT TIME',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            Text(
              appointment.time,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (appointment.status) {
                        context
                            .read<AppointmentCubit>()
                            .processAppointment(appointment);
                      }
                    },
                    icon: Icon(appointment.processed
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank)),
                const SizedBox(width: 8),
                const Text('MARK AS PROCESSED')
              ],
            ),
            const SizedBox(height: 24),
            appointment.processed
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (appointment.status) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirm'),
                                  content: const Text(
                                      'Mark this appointment as fulfilled? This action is irreversible'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Yes')),
                                  ],
                                ),
                              ).then((val) {
                                if (val) {
                                  context
                                      .read<AppointmentCubit>()
                                      .fulfillAppointment(appointment);
                                }
                              });
                            }
                          },
                          icon: Icon(appointment.status
                              ? Icons.check_box_outline_blank
                              : Icons.check_box_outlined)),
                      const SizedBox(width: 8),
                      const Text('MARK AS FULFILLED')
                    ],
                  )
                : Container()
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
