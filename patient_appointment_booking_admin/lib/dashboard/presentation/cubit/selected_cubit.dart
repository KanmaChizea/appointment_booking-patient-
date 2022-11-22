import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/entity/appontments.dart';

class SelectedCubit extends Cubit<AppointmentEntity?> {
  SelectedCubit() : super(null);

  void select(AppointmentEntity appointment) {
    emit(appointment);
  }

  void clear() {
    emit(null);
  }
}
