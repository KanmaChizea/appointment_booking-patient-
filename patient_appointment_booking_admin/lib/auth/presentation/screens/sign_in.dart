import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/auth/presentation/cubit/auth_cubit.dart';

import '../../../dashboard/presentation/screens/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
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
            content: Text(state.message),
            duration: const Duration(seconds: 3),
          ));
        }
        if (state is AuthSignedIn) {
          Navigator.pop(dialogContext);
          //fetch user data
          //navigate
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Dashboard()),
              (route) => false);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(100, 36, 100, 16),
          child: Column(
            children: [
              SizedBox(height: 100, width: 100, child: Image.asset('logo.png')),
              const SizedBox(height: 24),
              const Text('UNIVERSITY OF BENIN HEALTH CENTER',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 48),
              TextFormField(
                initialValue: 'admin',
                decoration: InputDecoration(
                  labelText: 'Usernames',
                  enabled: false,
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide()),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide()),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide()),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content: Text('Please enter password to login')));
                    } else {
                      context.read<AuthCubit>().signIn(_controller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 45)),
                  child: const Text('SIGN IN'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
