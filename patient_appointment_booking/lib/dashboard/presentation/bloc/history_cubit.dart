import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/appontments.dart';
import '../../domain/usecases/appointment_history.dart';

class HistoryState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryFailed extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<AppointmentEntity> appointments;

  HistoryLoaded(this.appointments);
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(AppointmentHistoryUsecase usecase)
      : _usecase = usecase,
        super(HistoryInitial());
  final AppointmentHistoryUsecase _usecase;

  Future<void> getHistory(String id) async {
    try {
      emit(HistoryLoading());
      final appointments = await _usecase(id);
      emit(HistoryLoaded(appointments));
    } catch (e) {
      emit(HistoryFailed());
    }
  }
}
