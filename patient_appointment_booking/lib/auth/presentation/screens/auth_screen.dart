import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking/dashboard/presentation/bloc/user_data_cubit.dart';
import '../../../dashboard/presentation/screens/dashboard.dart';
import '../../../core/responsive.dart';
import '../bloc/auth_cubit.dart';
import '../widgets/login.dart';
import '../widgets/signup.dart';

import '../bloc/bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(top: 12, left: 16),
            child: Image.asset('logo.png'),
          ),
          title: Responsive.isDesktop(context)
              ? const Text(
                  'UNIBEN Health Center Appointment Booking System',
                  style: TextStyle(color: Colors.black),
                )
              : null,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextButton(
                  onPressed: () => context.read<AuthCubit>().toggletoLogin(),
                  child: const Text('Sign in')),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 40, 0),
              child: ElevatedButton(
                  onPressed: () => context.read<AuthCubit>().toggletoSignup(),
                  child: const Text('Create an account')),
            ),
          ]),
      body: Column(
        children: [
          if (!Responsive.isDesktop(context))
            const Text(
              'UNIBEN Health Center Appointment Booking System',
              style: TextStyle(color: Colors.black, fontSize: 36),
            ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              BuildContext dialogContext = context;
              if (state is AuthLoading) {
                showDialog(
                    context: context,
                    builder: (context) {
                      dialogContext = context;
                      return const AlertDialog(
                        elevation: 10,
                        content: Center(child: CircularProgressIndicator()),
                      );
                    });
              }
              if (state is AuthFailed) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 3),
                ));
              }
              if (state is AuthSignedIn) {
                Navigator.pop(dialogContext);
                //fetch user data
                context.read<UserDataCubit>().fetchUser(state.uid);
                //navigate
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                    (route) => false);
              }
            },
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 36),
                child: Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 48),
                      width:
                          MediaQuery.of(context).size.width > 390 ? 500 : null,
                      decoration: BoxDecoration(
                          border: MediaQuery.of(context).size.width > 650
                              ? Border.all(width: 2, color: Colors.grey)
                              : null),
                      child: BlocBuilder<AuthCubit, bool>(
                        builder: (context, state) {
                          if (state) {
                            return const Login();
                          }
                          return const Signup();
                        },
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
