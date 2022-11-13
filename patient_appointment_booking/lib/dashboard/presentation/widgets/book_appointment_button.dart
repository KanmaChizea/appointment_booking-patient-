import 'package:flutter/material.dart';
import '../screens/book.dart';

class BookAppointmentButton extends StatelessWidget {
  const BookAppointmentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BookingScreen())),
        child: const Text('Book appointment'));
  }
}
