import 'package:get_it/get_it.dart';
import 'package:patient_appointment_booking/auth/data/repositories/auth_repository.dart';
import 'package:patient_appointment_booking/auth/data/source/auth_datasource.dart';
import 'package:patient_appointment_booking/auth/domain/repositories/auth_interface.dart';
import 'package:patient_appointment_booking/auth/domain/usecases/check_login_status.dart';
import 'package:patient_appointment_booking/auth/domain/usecases/create_account.dart';
import 'package:patient_appointment_booking/auth/presentation/bloc/bloc/auth_bloc.dart';

import 'domain/usecases/sign_in.dart';
import 'domain/usecases/sign_out.dart';

final _sl = GetIt.instance;

void init() {
  _sl.registerFactory(() => AuthBloc(
      createAccountUsecase: _sl(),
      signInUsecase: _sl(),
      signOutUsecase: _sl(),
      checkLoginStatusUsecase: _sl()));

  _sl.registerLazySingleton(() => CreateAccountUsecase(_sl()));
  _sl.registerLazySingleton(() => SignInUsecase(_sl()));
  _sl.registerLazySingleton(() => SignOutUsecase(_sl()));
  _sl.registerLazySingleton(() => CheckLoginStatusUsecase(_sl()));

  _sl.registerLazySingleton<AuthInterface>(
      () => AuthRepository(authDataSource: _sl()));

  _sl.registerLazySingleton(() => AuthDataSource());
}
