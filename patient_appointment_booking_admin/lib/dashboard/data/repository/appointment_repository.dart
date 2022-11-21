import 'package:patient_appointment_booking_admin/dashboard/data/source/appointment_datasource.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/entity/appontments.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/interface/appointment_interface.dart';

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
}
