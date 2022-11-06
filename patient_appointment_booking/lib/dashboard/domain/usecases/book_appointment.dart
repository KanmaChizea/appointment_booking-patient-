import '../entities/appontments.dart';

import '../repositories/dashboard_interface.dart';

class BookAppointmentUsecase {
  BookAppointmentUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<String> call(AppointmentEntity appointment) async {
    return await _dashboardInterface.bookAppointment(appointment);
  }
}
