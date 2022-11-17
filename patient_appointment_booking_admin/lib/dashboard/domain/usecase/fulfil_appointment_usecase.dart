import 'package:patient_appointment_booking_admin/dashboard/domain/entity/appontments.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/interface/appointment_interface.dart';

class FulfilAppointmentUsecase {
  FulfilAppointmentUsecase(AppointmentInterface appointmentInterface)
      : _appointmentInterface = appointmentInterface;
  final AppointmentInterface _appointmentInterface;

  Future<void> call(AppointmentEntity appointment) async {
    return await _appointmentInterface.markAsFulfilled(appointment);
  }
}
