import 'package:get_it/get_it.dart';
import 'data/repository/dashboard_repository.dart';
import 'data/source/dashboard_datasource.dart';
import 'domain/repositories/dashboard_interface.dart';
import 'domain/usecases/active_appointments.dart';
import 'domain/usecases/appointment_history.dart';
import 'domain/usecases/book_appointment.dart';
import 'domain/usecases/cancel_appointment.dart';
import 'domain/usecases/edit_profile.dart';
import 'presentation/bloc/appointment_management_cubit.dart';
import 'presentation/bloc/book_appointment_cubit.dart';
import 'presentation/bloc/history_cubit.dart';
import 'presentation/bloc/profile_cubit.dart';

final _sl = GetIt.instance;

void init() {
  //cubits
  _sl.registerFactory(() => AppointmentManagementCubit(
      activeAppointmentUsecase: _sl(), cancelAppointmentUsecase: _sl()));
  _sl.registerFactory(() => BookingCubit(_sl()));
  _sl.registerFactory(() => HistoryCubit(_sl()));
  _sl.registerFactory(() => ProfileCubit(_sl()));

  //usecases
  _sl.registerLazySingleton(() => ActiveAppointmentUsecase(_sl()));
  _sl.registerLazySingleton(() => CancelAppointmentUsecase(_sl()));
  _sl.registerLazySingleton(() => BookAppointmentUsecase(_sl()));
  _sl.registerLazySingleton(() => AppointmentHistoryUsecase(_sl()));
  _sl.registerLazySingleton(() => EditProfileUsecase(_sl()));

  //repository
  _sl.registerLazySingleton<DashboardInterface>(
      () => DashboardRepository(_sl()));

  //source
  _sl.registerLazySingleton(() => DashboardDataSource());
}
