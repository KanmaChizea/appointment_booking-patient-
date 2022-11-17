import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_booked_hours.dart';

class BookedHoursCubit extends Cubit<List<String>> {
  BookedHoursCubit(GetBookedHoursUsecase usecase)
      : _usecase = usecase,
        super(['-:-']);

  final GetBookedHoursUsecase _usecase;

  List workingHours = [
    '09:00 - 9:30',
    '9:30 - 10:00',
    '10:00 - 10:30',
    '10:30 - 11:00',
    '11:00 - 11:30',
    '11:30 - 12:00',
    '12:00 - 12:30',
    '12:30 - 13:00',
    '13:00 - 13:30',
    '13:30 - 14:00',
    '14:00 - 14:30',
    '14:30 - 15:00',
    '15:00 - 13:30',
    '15:30 - 16:00',
    '16:00 - 16:30',
    '16:30 - 17:00',
  ];

  void getHours(String date) async {
    final bookedHours = await _usecase(date);
    List<String> freeHours = [];
    for (var element in workingHours) {
      if (!bookedHours.contains(element)) {
        freeHours.add(element);
      }
    }
    freeHours.isEmpty
        ? emit(['-No available time for this date-'])
        : emit(freeHours);
  }
}
