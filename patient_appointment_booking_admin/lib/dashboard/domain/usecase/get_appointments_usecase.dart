import 'package:patient_appointment_booking_admin/dashboard/domain/entity/appontments.dart';

import '../interface/appointment_interface.dart';

class GetAppointmentUsecase {
  GetAppointmentUsecase(AppointmentInterface appointmentInterface)
      : _appointmentInterface = appointmentInterface;
  final AppointmentInterface _appointmentInterface;

  Stream<List<AppointmentEntity>> call() {
    return _appointmentInterface.getAllAppointments();
  }
}
