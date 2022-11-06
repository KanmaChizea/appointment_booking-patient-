import '../entities/appontments.dart';

import '../repositories/dashboard_interface.dart';

class ActiveAppointmentUsecase {
  ActiveAppointmentUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<List<AppointmentEntity>> call() async {
    return await _dashboardInterface.getActiveAppointment();
  }
}
