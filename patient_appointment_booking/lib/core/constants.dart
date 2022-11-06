import 'package:flutter/material.dart';

import '../dashboard/data/models/dashboard_element.dart';

List<DashboardElement> dashboardElementList = [
  DashboardElement(
      title: 'Upcoming Appointments',
      icon: Icons.calendar_month_outlined,
      subtitle: 'Manage Your Upcoming Appointments',
      buttonText: 'View Appointments',
      route: Container()),
  DashboardElement(
      title: 'Appointment History',
      icon: Icons.history,
      subtitle: 'View Your Appointment History',
      buttonText: 'See History',
      route: Container()),
  DashboardElement(
      title: 'Profile',
      icon: Icons.account_circle_outlined,
      subtitle: 'Edit Your Profile',
      buttonText: 'Edit Profile',
      route: Container()),
];
