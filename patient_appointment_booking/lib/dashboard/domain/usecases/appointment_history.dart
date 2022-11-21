import '../entities/appontments.dart';
import '../repositories/dashboard_interface.dart';

class AppointmentHistoryUsecase {
  AppointmentHistoryUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<List<AppointmentEntity>> call(String id) async {
    return await _dashboardInterface.getAppointmentHistory(id);
  }
}
