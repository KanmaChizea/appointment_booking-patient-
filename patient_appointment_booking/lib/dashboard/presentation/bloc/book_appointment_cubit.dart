import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/appontments.dart';
import '../../domain/usecases/book_appointment.dart';

class BookingType extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class BookingInitial extends BookingType {}

class BookingLoading extends BookingType {}

class BookingFailed extends BookingType {}

class BookingSuccessful extends BookingType {
  final String id;

  BookingSuccessful(this.id);
}

class BookingCubit extends Cubit<BookingType> {
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
}
