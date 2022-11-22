import 'package:patient_appointment_booking_admin/dashboard/domain/entity/user_entity.dart';

import '../interface/appointment_interface.dart';

class GetUsersUsecase {
  GetUsersUsecase(AppointmentInterface appointmentInterface)
      : _appointmentInterface = appointmentInterface;
  final AppointmentInterface _appointmentInterface;

  Stream<List<UserData>> call() {
    return _appointmentInterface.getAllUsers();
  }
}
