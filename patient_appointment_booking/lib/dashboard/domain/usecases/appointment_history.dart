import 'package:patient_appointment_booking/dashboard/domain/entities/appontments.dart';

import '../repositories/dashboard_interface.dart';

class AppointmentHistoryUsecase {
  AppointmentHistoryUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<List<AppointmentEntity>> call() async {
    return await _dashboardInterface.getAppointmentHistory();
  }
}
