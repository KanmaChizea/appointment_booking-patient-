import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/responsive.dart';
import '../bloc/history_cubit.dart';
import '../widgets/appbar.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/failed_state.dart';
import '../widgets/welcome_user.dart';
import 'appointment.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppbar(context: context, title: 'Historys history'),
      body: SingleChildScrollView(
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(80, 36, 80, 0)
              : const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!Responsive.isDesktop(context))
                const Text(
                  'History',
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
              BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryFailed) {
                    return FailedState(
                        onPressed: () =>
                            context.read<HistoryCubit>().getHistory());
                  } else if (state is HistoryLoaded) {
                    if (state.appointments.isNotEmpty) {
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
                      List<TableRow> historyList = state.appointments
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
                          children: List.from(tableList)..addAll(historyList),
                        ),
                      );
                    } else {
                      return const Center(child: Text('You have no history'));
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
