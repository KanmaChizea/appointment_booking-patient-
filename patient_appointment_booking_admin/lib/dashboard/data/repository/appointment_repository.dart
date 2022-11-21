import 'package:patient_appointment_booking_admin/dashboard/data/source/appointment_datasource.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/entity/appontments.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/interface/appointment_interface.dart';

class AppointmentRepository implements AppointmentInterface {
  AppointmentRepository(AppointmentDataSource dataSource)
      : _dataSource = dataSource;
  final AppointmentDataSource _dataSource;

  @override
  Stream<List<AppointmentEntity>> getAllAppointments() {
    // TODO: implement getAllAppointments
    throw UnimplementedError();
  }

  @override
  Future<void> markAsFulfilled(AppointmentEntity appointment) {
    // TODO: implement markAsFulfilled
    throw UnimplementedError();
  }
}
