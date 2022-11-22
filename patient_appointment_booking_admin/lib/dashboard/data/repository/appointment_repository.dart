import 'package:patient_appointment_booking_admin/dashboard/domain/entity/user_entity.dart';

import '../source/appointment_datasource.dart';
import '../../domain/entity/appontments.dart';
import '../../domain/interface/appointment_interface.dart';

class AppointmentRepository implements AppointmentInterface {
  AppointmentRepository(AppointmentDataSource dataSource)
      : _dataSource = dataSource;
  final AppointmentDataSource _dataSource;

  @override
  Stream<List<AppointmentEntity>> getAllAppointments() {
    return _dataSource.getAllAppointments();
  }

  @override
  Future<void> markAsFulfilled(AppointmentEntity appointment) async {
    await _dataSource.markAsFulfilled(appointment);
  }

  @override
  Stream<List<UserData>> getAllUsers() {
    return _dataSource.getUser();
  }
}
