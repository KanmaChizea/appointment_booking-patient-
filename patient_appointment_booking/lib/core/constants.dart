import 'package:flutter/material.dart';

import '../dashboard/data/models/dashboard_element.dart';
import '../dashboard/presentation/screens/appointment.dart';
import '../dashboard/presentation/screens/edit_profile.dart';
import '../dashboard/presentation/screens/history.dart';

List<DashboardElement> dashboardElementList = [
  DashboardElement(
      title: 'Upcoming Appointments',
      icon: Icons.calendar_month_outlined,
      subtitle: 'Manage Your Upcoming Appointments',
      buttonText: 'View Appointments',
      route: const AppointmentsScreen()),
  DashboardElement(
      title: 'Appointment History',
      icon: Icons.history,
      subtitle: 'View Your Appointment History',
      buttonText: 'See History',
      route: const HistoryScreen()),
  DashboardElement(
      title: 'Profile',
      icon: Icons.account_circle_outlined,
      subtitle: 'Edit Your Profile',
      buttonText: 'Edit Profile',
      route: const ProfileScreen()),
];
