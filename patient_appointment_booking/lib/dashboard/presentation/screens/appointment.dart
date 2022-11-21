import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/appontments.dart';
import '../bloc/appointment_management_cubit.dart';

import '../../../core/responsive.dart';
import '../bloc/user_data_cubit.dart';
import '../widgets/appbar.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/failed_state.dart';
import '../widgets/welcome_user.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  void initState() {
    context
        .read<AppointmentManagementCubit>()
        .getAppointments(context.read<UserDataCubit>().state.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppbar(context: context, title: 'Active appointments'),
      body: SingleChildScrollView(
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(80, 36, 80, 0)
              : const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!Responsive.isDesktop(context))
                const Text(
                  'Active appointments',
                  style: TextStyle(color: Colors.black, fontSize: 36),
                ),
              const SizedBox(height: 16),
              if (Responsive.isMobile(context))
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [WelcomeUser(), BookAppointmentButton()],
                  ),
                ),
              const SizedBox(height: 16),
              BlocBuilder<AppointmentManagementCubit, AppointmentState>(
                builder: (context, state) {
                  final id = context.read<UserDataCubit>().state.id;
                  if (state is AppointmentFailed) {
                    return FailedState(
                        onPressed: () => context
                            .read<AppointmentManagementCubit>()
                            .getAppointments(id));
                  } else if (state is AppointmentLoaded) {
                    if (state.appoinments.isNotEmpty) {
                      const List<TableRow> tableList = [
                        TableRow(children: [
                          AppointmentCell(
                              child: Text('APPOINTMENT ID',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          AppointmentCell(
                              child: Text('APPOINTMENT DATE',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          AppointmentCell(
                              child: Text('APPOINTMENT TIME',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          AppointmentCell(
                              child: Text('APPOINTMENT STATUS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ])
                      ];
                      List<TableRow> appointmentList = state.appoinments
                          .map((e) => AppointmentRow(e, context))
                          .toList();

                      return Padding(
                        padding: Responsive.isMobile(context)
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.symmetric(horizontal: 150),
                        child: Table(
                          border: const TableBorder(
                            bottom: BorderSide(color: Colors.grey),
                            horizontalInside: BorderSide(color: Colors.grey),
                          ),
                          children: List.from(tableList)
                            ..addAll(appointmentList),
                        ),
                      );
                    } else {
                      return const Center(
                          child: Text('You have no upcoming appointments'));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          )),
    );
  }
}

class AppointmentRow extends TableRow {
  AppointmentRow(AppointmentEntity item, BuildContext context)
      : super(children: [
          AppointmentCell(child: Text(item.id!)),
          AppointmentCell(child: Text(item.date)),
          AppointmentCell(child: Text(item.time)),
          if (item.status)
            AppointmentCell(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(radius: 4, backgroundColor: Colors.green.shade500),
                const SizedBox(width: 8),
                const Text('ACTIVE'),
                const Spacer(),
                IconButton(
                    onPressed: () => context
                        .read<AppointmentManagementCubit>()
                        .cancelAppointment(item),
                    icon: Icon(
                      Icons.close,
                      color: Colors.red.shade800,
                    ))
              ],
            )),
        ]);
}

class AppointmentCell extends StatelessWidget {
  const AppointmentCell({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ));
  }
}
