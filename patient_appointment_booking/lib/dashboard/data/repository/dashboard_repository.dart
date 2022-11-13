import '../source/dashboard_datasource.dart';
import '../../domain/entities/appontments.dart';
import '../../domain/repositories/dashboard_interface.dart';

import '../../../auth/domain/entitis/user_data.dart';

class DashboardRepository implements DashboardInterface {
  DashboardRepository(DashboardDataSource dataSource)
      : _dataSource = dataSource;
  final DashboardDataSource _dataSource;
  @override
  Future<String> bookAppointment(
      AppointmentEntity appointment, List<String> index) async {
    try {
      return await _dataSource.bookAppointment(appointment, index);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelAppointment(AppointmentEntity appointment) async {
    try {
      return await _dataSource.cancelAppointment(appointment);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editProfile(UserData data) async {
    try {
      return await _dataSource.editProfile(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentEntity>> getActiveAppointment() async {
    try {
      return await _dataSource.getActiveAppointment();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentEntity>> getAppointmentHistory() async {
    try {
      return await _dataSource.getAppointmentHistory();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getBookedTimes(String date) async {
    try {
      return await _dataSource.getBookedTimes(date);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<UserData> fetchUser(String uid) {
    return _dataSource.fetchData(uid);
  }
}
