import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/presentation/cubit/appointment_cubit.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  String filter = 'All';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Filter:'),
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton2(
                buttonHeight: 40,
                itemHeight: 40,
                value: filter,
                items: ['All', 'Pending']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    filter = value!;
                  });
                  context.read<AppointmentCubit>().filterAppointment(value!);
                }),
          ),
        )
      ],
    );
  }
}
