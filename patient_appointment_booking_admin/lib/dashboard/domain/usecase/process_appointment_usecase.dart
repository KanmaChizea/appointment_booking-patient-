import '../entity/appontments.dart';
import '../interface/appointment_interface.dart';

class ProcessAppointmentUsecase {
  ProcessAppointmentUsecase(AppointmentInterface appointmentInterface)
      : _appointmentInterface = appointmentInterface;
  final AppointmentInterface _appointmentInterface;

  Future<void> call(AppointmentEntity appointment) async {
    return await _appointmentInterface.markAsProcessed(appointment);
  }
}
