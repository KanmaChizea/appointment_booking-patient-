import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/appontments.dart';
import '../../domain/usecase/fulfil_appointment_usecase.dart';
import '../../domain/usecase/get_appointments_usecase.dart';

class AppointmentCubit extends Cubit<List<AppointmentEntity>> {
  AppointmentCubit(GetAppointmentUsecase usecase)
      : _usecase = usecase,
        super([]);

  final GetAppointmentUsecase _usecase;
  List<AppointmentEntity> appointments = [];

  void getAppointments() {
    _usecase().listen((event) {
      appointments = [...event];
      emit(event);
    });
  }

  void filterAppointment(String filter) {
    final List<AppointmentEntity> list = List.from(appointments);
    if (filter == 'Pending') {
      final List<AppointmentEntity> newList =
          list.where((element) => element.status == true).toList();
      emit(newList);
    } else {
      reset();
    }
  }

  void search(String value) {
    final List<AppointmentEntity> searched = [];
    for (var i in appointments) {
      if (i.id!.toLowerCase().contains(value.toLowerCase())) {
        searched.add(i);
      }
    }
    emit(searched);
  }

  void reset() {
    emit(appointments);
  }
}

class FulfillCubit extends Cubit<bool> {
  FulfillCubit(FulfilAppointmentUsecase usecase)
      : _usecase = usecase,
        super(false);
  final FulfilAppointmentUsecase _usecase;

  void toggleFulfillment(AppointmentEntity appointment) async {
    await _usecase(appointment);
    emit(!state);
  }
}
