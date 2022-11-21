import '../../../auth/domain/entitis/user_data.dart';
import '../repositories/dashboard_interface.dart';

class FetchUserDataUsecase {
  FetchUserDataUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Stream<UserData> call(String data) {
    return _dashboardInterface.fetchUser(data);
  }
}
