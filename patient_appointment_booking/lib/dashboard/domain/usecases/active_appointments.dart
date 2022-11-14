import '../entities/appontments.dart';

import '../repositories/dashboard_interface.dart';

class ActiveAppointmentUsecase {
  ActiveAppointmentUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Stream<List<AppointmentEntity>> call() {
    return _dashboardInterface.getActiveAppointment();
  }
}
