import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking/auth/domain/entitis/user_data.dart';
import 'package:patient_appointment_booking/auth/presentation/bloc/bloc/auth_bloc.dart';

import 'authform_layout.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController id;
  late TextEditingController department;
  late TextEditingController faculty;
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    faculty = TextEditingController();
    firstName = TextEditingController();
    id = TextEditingController();
    department = TextEditingController();
    lastName = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Signup',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text('Create an account. Its easy and free',
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 32),
        AuthFormLayout(formKey: _key, controllerList: [
          {'controller': id, 'hint': 'ID'},
          {'controller': email, 'hint': 'Email'},
          {'controller': firstName, 'hint': 'First name'},
          {'controller': lastName, 'hint': 'Last name'},
          {'controller': faculty, 'hint': 'Faculty'},
          {'controller': department, 'hint': 'Department'},
          {'controller': password, 'hint': 'Password'},
        ]),
        const SizedBox(height: 32),
        ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                final userData = UserData(
                    firstName: firstName.text,
                    lastName: lastName.text,
                    department: department.text,
                    faculty: faculty.text,
                    id: id.text);
                context.read<AuthBloc>().add(AuthSignUp(
                    email: email.text,
                    password: password.text,
                    userData: userData));
              }
            },
            child: const Text('Signup'))
      ],
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    id.dispose();
    firstName.dispose();
    lastName.dispose();
    department.dispose();
    faculty.dispose();
    super.dispose();
  }
}
