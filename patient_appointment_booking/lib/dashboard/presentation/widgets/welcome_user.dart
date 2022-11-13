import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entitis/user_data.dart';
import '../bloc/user_data_cubit.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserData>(
      builder: (context, state) {
        final name = '${state.firstName} ${state.lastName}';
        return Text('Hello, $name',
            style: const TextStyle(color: Colors.black));
      },
    );
  }
}
