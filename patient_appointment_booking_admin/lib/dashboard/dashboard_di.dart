import 'package:get_it/get_it.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/usecase/get_users_usecase.dart';
import 'data/repository/appointment_repository.dart';
import 'data/source/appointment_datasource.dart';
import 'domain/interface/appointment_interface.dart';
import 'domain/usecase/fulfil_appointment_usecase.dart';
import 'domain/usecase/get_appointments_usecase.dart';
import 'presentation/cubit/appointment_cubit.dart';
import 'presentation/cubit/selected_cubit.dart';
import 'presentation/cubit/user_cubit.dart';

final _sl = GetIt.instance;

void init() {
  _sl.registerFactory(() => AppointmentCubit(_sl()));
  _sl.registerFactory(() => FulfillCubit(_sl()));
  _sl.registerFactory(() => SelectedCubit());
  _sl.registerFactory(() => UserCubit(_sl()));

  _sl.registerLazySingleton(() => GetAppointmentUsecase(_sl()));
  _sl.registerLazySingleton(() => FulfilAppointmentUsecase(_sl()));
  _sl.registerLazySingleton(() => GetUsersUsecase(_sl()));

  _sl.registerLazySingleton<AppointmentInterface>(
      () => AppointmentRepository(_sl()));

  _sl.registerLazySingleton(() => AppointmentDataSource());
}
