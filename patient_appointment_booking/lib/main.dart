import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/presentation/bloc/auth_cubit.dart';
import 'auth/presentation/bloc/bloc/auth_bloc.dart';
import 'auth/presentation/screens/auth_screen.dart';
import 'dashboard/presentation/bloc/appointment_management_cubit.dart';
import 'dashboard/presentation/bloc/book_appointment_cubit.dart';
import 'dashboard/presentation/bloc/booked_hours_cubit.dart';
import 'dashboard/presentation/bloc/edit_profile_cubit.dart';
import 'dashboard/presentation/bloc/history_cubit.dart';
import 'dashboard/presentation/bloc/user_data_cubit.dart';
import 'dashboard/presentation/screens/dashboard.dart';
import 'depenency_injection.dart' as di;
import 'firebase_options.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(CheckAuthStatus()),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserDataCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<BookingCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<HistoryCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<EditProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<BookedHoursCubit>(),
        ),
        BlocProvider(create: (context) => di.sl<AppointmentManagementCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSignIn) {
              return const Dashboard();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
