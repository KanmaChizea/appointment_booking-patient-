import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/presentation/cubit/auth_cubit.dart';
import 'auth/presentation/screens/sign_in.dart';
import 'dashboard/presentation/cubit/selected_cubit.dart';
import 'dashboard/presentation/cubit/user_cubit.dart';
import 'dashboard/presentation/screens/dashboard.dart';
import 'dashboard/presentation/cubit/appointment_cubit.dart';
import 'dependecy_injection.dart' as di;
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
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(
            create: (context) => di.sl<AppointmentCubit>()..getAppointments()),
        BlocProvider(create: (context) => di.sl<FulfillCubit>()),
        BlocProvider(create: (context) => di.sl<SelectedCubit>()),
        BlocProvider(
            create: (context) => di.sl<UserCubit>()..getAllUsers(),
            lazy: false),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const Dashboard(),
      ),
    );
  }
}
