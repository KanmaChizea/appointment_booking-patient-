import '../../../auth/domain/entitis/user_data.dart';
import '../repositories/dashboard_interface.dart';

class EditProfileUsecase {
  EditProfileUsecase(DashboardInterface dashboardInterface)
      : _dashboardInterface = dashboardInterface;
  final DashboardInterface _dashboardInterface;

  Future<void> call(UserData data) async {
    await _dashboardInterface.editProfile(data);
  }
}
