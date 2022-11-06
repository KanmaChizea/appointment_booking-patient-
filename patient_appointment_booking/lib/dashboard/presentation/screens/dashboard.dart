import 'package:flutter/material.dart';
import '../../../core/constants.dart';

import '../../../core/responsive.dart';
import '../widgets/book_appointment_button.dart';
import '../widgets/welcome_user.dart';

import '../widgets/appbar.dart';
import '../widgets/dashboard_element_container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppbar(context: context),
      body: SingleChildScrollView(
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(80, 36, 80, 0)
              : const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 32),
              const Text('Next appointment'),
              const SizedBox(height: 24),
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
