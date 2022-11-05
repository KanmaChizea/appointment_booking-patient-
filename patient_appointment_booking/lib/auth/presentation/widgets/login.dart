import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:patient_appointment_booking/auth/presentation/widgets/authform_layout.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email;
  late TextEditingController password;
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Fill in the form below to gain access',
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 32),
        AuthFormLayout(formKey: _key, controllerList: [
          {'controller': email, 'hint': 'Email'},
          {'controller': password, 'hint': 'Password'},
        ]),
        const SizedBox(height: 32),
        ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                context.read<AuthBloc>().add(
                    AuthSignIn(email: email.text, password: password.text));
              }
            },
            child: const Text('Login'))
      ],
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
