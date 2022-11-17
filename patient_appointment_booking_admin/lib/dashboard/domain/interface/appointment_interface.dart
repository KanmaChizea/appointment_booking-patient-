import 'package:patient_appointment_booking_admin/dashboard/domain/entity/appontments.dart';

abstract class AppointmentInterface {
  Stream<List<AppointmentEntity>> getAllAppointments();
  Future<void> markAsFulfilled(AppointmentEntity appointment);
}
