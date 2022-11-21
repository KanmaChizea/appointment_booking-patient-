import '../source/dashboard_datasource.dart';
import '../../domain/entities/appontments.dart';
import '../../domain/repositories/dashboard_interface.dart';

import '../../../auth/domain/entitis/user_data.dart';

class DashboardRepository implements DashboardInterface {
  DashboardRepository(DashboardDataSource dataSource)
      : _dataSource = dataSource;
  final DashboardDataSource _dataSource;
  @override
  Future<String> bookAppointment(AppointmentEntity appointment) async {
    try {
      return await _dataSource.bookAppointment(appointment);
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
  Stream<List<AppointmentEntity>> getActiveAppointment(String id) {
    try {
      return _dataSource.getActiveAppointment(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentEntity>> getAppointmentHistory(String id) async {
    try {
      return await _dataSource.getAppointmentHistory(id);
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
