import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/appontments.dart';
import '../bloc/book_appointment_cubit.dart';
import '../bloc/booked_hours_cubit.dart';
import '../bloc/user_data_cubit.dart';
import '../../../auth/domain/entitis/user_data.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late DateTime selectedDate;
  bool _enableButton = false;
  @override
  void initState() {
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    selectedDate = (DateTime.now().weekday == 7)
        ? DateTime.now().add(const Duration(days: 1))
        : DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select date for appointment'),
        const SizedBox(height: 8),
        TextField(
            controller: _dateController,
            onTap: () async {
              final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  initialDatePickerMode: DatePickerMode.day,
                  selectableDayPredicate: (val) {
                    return val.weekday == 7 ? false : true;
                  },
                  firstDate: DateTime.now(),
                  lastDate: DateTime(
                      DateTime.now().add(const Duration(days: 90)).year));
              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                  _dateController.text = _dateController.text =
                      DateFormat.yMd().format(selectedDate);
                });
                // ignore: use_build_context_synchronously
                context.read<BookedHoursCubit>().getHours(_dateController.text);
              }
            },
            decoration: const InputDecoration(
              hintText: 'DD/MM/YYYY',
              counterText: '',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            )),
        const SizedBox(height: 24),
        const Text('Select time for appointment'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              hintText: 'Available times',
              counterText: '',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder()),
          items: context.watch<BookedHoursCubit>().state.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _timeController.text = value!;
              _enableButton = true;
            });
          },
        ),
        const SizedBox(height: 48),
        BlocBuilder<UserDataCubit, UserData>(
          builder: (context, state) {
            return Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    if (_enableButton) {
                      final list = context.read<BookedHoursCubit>().state;
                      final appointment = AppointmentEntity(
                          date: _dateController.text,
                          time: _timeController.text,
                          patientId: state.id,
                          status: true);
                      context
                          .read<BookingCubit>()
                          .bookAppointment(appointment, list);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (_) => _enableButton ? Colors.purple : Colors.grey),
                    overlayColor: MaterialStateProperty.resolveWith((_) =>
                        _enableButton
                            ? Colors.purple.shade100
                            : Colors.transparent),
                    elevation: MaterialStateProperty.resolveWith(
                        (_) => _enableButton ? 3 : 0),
                  ),
                  child: const Text('Book appointment')),
            );
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
