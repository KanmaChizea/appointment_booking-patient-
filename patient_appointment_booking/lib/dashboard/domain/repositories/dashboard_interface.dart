import '../entities/appontments.dart';

import '../../../auth/domain/entitis/user_data.dart';

abstract class DashboardInterface {
  Future<String> bookAppointment(AppointmentEntity appointment);
  Future<List<AppointmentEntity>> getActiveAppointment();
  Future<void> cancelAppointment(AppointmentEntity appointment);
  Future<List<AppointmentEntity>> getAppointmentHistory();
  Future<void> editProfile(UserData data);
  Future<List<String>> getBookedTimes(String date);
}
