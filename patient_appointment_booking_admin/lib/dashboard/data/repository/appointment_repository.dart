import 'package:patient_appointment_booking_admin/dashboard/domain/interface/appontments.dart';

abstract class AppointmentInterface {
  Stream<List<AppointmentEntity>> getAllAppointments();
  Future<void> markAsFulfilled(AppointmentEntity appointment);
}
