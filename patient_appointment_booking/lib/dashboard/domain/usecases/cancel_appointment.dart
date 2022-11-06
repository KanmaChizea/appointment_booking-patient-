import '../entities/appontments.dart';
import '../repositories/dashboard_interface.dart';

class CancelAppointmentUsecase {
  CancelAppointmentUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<void> call(AppointmentEntity appointment) async {
    await _dashboardInterface.cancelAppointment(appointment);
  }
}
