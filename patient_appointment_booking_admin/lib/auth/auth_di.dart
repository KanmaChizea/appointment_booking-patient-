import 'package:get_it/get_it.dart';
import 'package:patient_appointment_booking_admin/auth/data/repository/auth_repository.dart';
import 'package:patient_appointment_booking_admin/auth/data/source/auth_datasource.dart';
import 'package:patient_appointment_booking_admin/auth/domain/interface/auth_interface.dart';
import 'package:patient_appointment_booking_admin/auth/domain/usecase/sign_in_usecase.dart';
import 'package:patient_appointment_booking_admin/auth/presentation/cubit/auth_cubit.dart';

final _sl = GetIt.instance;

void init() {
  _sl.registerFactory(() => AuthCubit(signInUseCase: _sl()));
  _sl.registerLazySingleton(() => SignInUseCase(_sl()));
  _sl.registerLazySingleton<AuthInterface>(() => AuthRepository(_sl()));
  _sl.registerLazySingleton(() => AuthDataSource());
}
