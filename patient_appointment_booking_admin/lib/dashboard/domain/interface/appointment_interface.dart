import 'package:patient_appointment_booking_admin/dashboard/domain/entity/user_entity.dart';

import '../entity/appontments.dart';

abstract class AppointmentInterface {
  Stream<List<AppointmentEntity>> getAllAppointments();
  Stream<List<UserData>> getAllUsers();
  Future<void> markAsFulfilled(AppointmentEntity appointment);
}
