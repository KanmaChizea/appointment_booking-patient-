import 'package:patient_appointment_booking/dashboard/domain/entities/appontments.dart';
import 'package:patient_appointment_booking/dashboard/domain/repositories/dashboard_interface.dart';

class CancelAppointmentUsecase {
  CancelAppointmentUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<void> call(AppointmentEntity appointment) async {
    await _dashboardInterface.cancelAppointment(appointment);
  }
}
