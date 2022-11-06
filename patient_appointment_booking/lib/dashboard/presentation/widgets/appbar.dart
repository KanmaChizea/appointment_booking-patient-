import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/responsive.dart';

import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/screens/auth_screen.dart';
import 'book_appointment_button.dart';
import 'welcome_user.dart';

class DashboardAppbar extends AppBar {
  DashboardAppbar({
    required BuildContext context,
    Key? key,
  }) : super(
            key: key,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(top: 12, left: 16),
              child: Image.asset('logo.png'),
            ),
            title: Responsive.isDesktop(context)
                ? const Text(
                    'Patient Dashboard',
                    style: TextStyle(color: Colors.black),
                  )
                : null,
            actions: [
              if (!Responsive.isMobile(context))
                const Padding(
                    padding: EdgeInsets.only(top: 28), child: WelcomeUser()),
              if (!Responsive.isMobile(context))
                const Padding(
                  padding: EdgeInsets.only(top: 12, left: 24),
                  child: BookAppointmentButton(),
                ),
              Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.fromLTRB(24, 12, 40, 0)
                    : const EdgeInsets.fromLTRB(8, 12, 16, 0),
                child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignOut());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AuthScreen()),
                          (route) => false);
                    },
                    child: const Text('Logout')),
              ),
            ]);
}
