import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSignedIn) {
          final name =
              '${state.userEntity.userdata.firstName[0]} ${state.userEntity.userdata.lastName}';
          return Text('Hello, $name',
              style: const TextStyle(color: Colors.black));
        }
        return const Text('Hello, Anon', style: TextStyle(color: Colors.black));
      },
    );
  }
}
