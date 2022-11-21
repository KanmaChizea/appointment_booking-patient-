import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants.dart';
import '../../../core/responsive.dart';
import '../../domain/entities/appontments.dart';
import '../bloc/appointment_management_cubit.dart';
import '../bloc/user_data_cubit.dart';
import '../widgets/appbar.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/dashboard_element_container.dart';
import '../widgets/welcome_user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> getDates(List<AppointmentEntity> appointments) {
    List<String> list = [];
    for (var i in appointments) {
      list.add('${i.date.replaceAll('/', '-')} ${i.time.substring(0, 5)}:00');
    }
    return list;
  }

  String getClosestAppointment(List<String> dates) {
    final dateTimes = List.generate(dates.length,
        (index) => DateFormat("dd-MM-yyyy hh:mm:ss").parse(dates[index]));
    final now = DateTime.now();

    final closetsDateTimeToNow = dateTimes.reduce(
        (a, b) => a.difference(now).abs() < b.difference(now).abs() ? a : b);
    return DateFormat.yMd().add_jms().format(closetsDateTimeToNow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: DashboardAppbar(
            context: context, title: 'Patient Dashboard', isLeading: true),
      ),
      body: SingleChildScrollView(
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(80, 36, 80, 0)
              : const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!Responsive.isDesktop(context))
                const Text(
                  'Patient Dashboard',
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
              const Text('Quick view',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text(
                  'Here, you can view updates of your upcoming appointments',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              BlocBuilder<AppointmentManagementCubit, AppointmentState>(
                builder: (context, state) {
                  if (state is AppointmentLoaded) {
                    if (state.appoinments.isEmpty) {
                      return const Text('You have no upcoming appointments');
                    }
                    final dates = getDates(state.appoinments);

                    final nextAppointment = getClosestAppointment(dates);
                    return Text('Your next appointment is on $nextAppointment');
                  } else if (state is AppointmentFailed) {
                    return const Text('Couldnt fetch next appointment');
                  } else {
                    return const Text('...fetching next appointment');
                  }
                },
              ),
              const SizedBox(height: 32),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
                    crossAxisSpacing: 36,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 350),
                itemBuilder: (context, index) => DashboardElementContainer(
                  dashboardElement: dashboardElementList[index],
                ),
                itemCount: dashboardElementList.length,
              ),
              const SizedBox(height: 300)
            ],
          )),
    );
  }
}
