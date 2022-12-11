import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/usecase/fulfil_appointment_usecase.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/usecase/process_appointment_usecase.dart';
import '../../domain/entity/appontments.dart';
import '../../domain/usecase/get_appointments_usecase.dart';

class AppointmentCubitState {
  final List<AppointmentEntity> appointmentList;
  final int selected;

  AppointmentCubitState(this.appointmentList, this.selected);

  AppointmentCubitState copyWith(
          {List<AppointmentEntity>? appointmentList, int? selected}) =>
      AppointmentCubitState(
          appointmentList ?? this.appointmentList, selected ?? this.selected);
}

class AppointmentCubit extends Cubit<AppointmentCubitState> {
  AppointmentCubit(
      {required GetAppointmentUsecase getUsecase,
      required FulfilAppointmentUsecase fulfilUsecase,
      required ProcessAppointmentUsecase processUsecase})
      : _getUsecase = getUsecase,
        _fulfilUsecase = fulfilUsecase,
        _processUsecase = processUsecase,
        super(AppointmentCubitState([], 0));

  final GetAppointmentUsecase _getUsecase;
  final FulfilAppointmentUsecase _fulfilUsecase;
  final ProcessAppointmentUsecase _processUsecase;
  List<AppointmentEntity> appointments = [];

  void getAppointments() {
    _getUsecase().listen((event) {
      appointments = [...event];
      emit(state.copyWith(appointmentList: appointments));
    });
  }

  void filterAppointment(String filter) {
    final List<AppointmentEntity> list = List.from(appointments);
    if (filter == 'Pending') {
      final List<AppointmentEntity> newList =
          list.where((element) => element.status == true).toList();
      emit(state.copyWith(appointmentList: newList));
    } else {
      reset();
    }
  }

  void selectAppointment(int select) {
    emit(state.copyWith(selected: select + 1));
  }

  void clearAppointment() {
    emit(state.copyWith(selected: 0));
  }

  void fulfillAppointment(AppointmentEntity appointment) async {
    await _fulfilUsecase(appointment);
  }

  void processAppointment(AppointmentEntity appointment) async {
    await _processUsecase(appointment);
  }

  void search(String value) {
    final List<AppointmentEntity> searched = [];
    for (var i in appointments) {
      if (i.id!.toLowerCase().contains(value.toLowerCase())) {
        searched.add(i);
      }
    }
    emit(state.copyWith(appointmentList: searched));
  }

  void reset() {
    emit(state.copyWith(appointmentList: appointments));
  }
}
