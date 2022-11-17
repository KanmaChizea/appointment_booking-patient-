import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/appontments.dart';
import '../../domain/usecases/book_appointment.dart';

class BookingState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingFailed extends BookingState {}

class BookingSuccessful extends BookingState {
  final String id;

  BookingSuccessful(this.id);
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(BookAppointmentUsecase usecase)
      : _usecase = usecase,
        super(BookingInitial());
  final BookAppointmentUsecase _usecase;

  Future<void> bookAppointment(AppointmentEntity appointment) async {
    try {
      emit(BookingLoading());
      final id = await _usecase(appointment);
      emit(BookingSuccessful(id));
    } catch (e) {
      emit(BookingFailed());
    }
  }

  void reset() {
    log('called');
    emit(BookingInitial());
  }
}
