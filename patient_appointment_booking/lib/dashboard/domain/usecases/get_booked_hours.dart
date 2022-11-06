import '../repositories/dashboard_interface.dart';

class GetBookedHoursUsecase {
  GetBookedHoursUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<List<String>> call(String date) async {
    return await _dashboardInterface.getBookedTimes(date);
  }
}
