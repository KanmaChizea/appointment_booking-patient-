import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_appointment_cubit.dart';
import '../widgets/booking_details.dart';

import '../../../core/responsive.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            title: const Text('Book an appointment')),
        body: SingleChildScrollView(
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.fromLTRB(80, 36, 80, 0)
              : const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Center(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 48),
                  width: MediaQuery.of(context).size.width > 390 ? 500 : null,
                  height: MediaQuery.of(context).size.width > 390 ? 500 : null,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: MediaQuery.of(context).size.width > 650
                          ? Border.all(width: 2, color: Colors.grey)
                          : null),
                  child: BlocBuilder<BookingCubit, BookingState>(
                    builder: (context, state) {
                      if (state is BookingInitial) {
                        return const BookingDetails();
                      } else if (state is BookingFailed) {
                        return Column(
                          children: [
                            const Icon(Icons.error,
                                color: Colors.red, size: 36),
                            const SizedBox(height: 16),
                            const Text('Something went wrong',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            const Text('Could not book appointment',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                                onPressed: () =>
                                    context.read<BookingCubit>().reset(),
                                label: const Text('Try again'),
                                icon: const Icon(Icons.redo))
                          ],
                        );
                      } else if (state is BookingSuccessful) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 36),
                            const SizedBox(height: 16),
                            const Text('Booking successful',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'Your ticket no is ',
                                    style: const TextStyle(fontSize: 16),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${state.id.substring(0, 10).toUpperCase()}.',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      const TextSpan(
                                        text:
                                            "\n You'll be required to provide this number when you get to the health center to fulfill your appointment",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ])),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                                onPressed: () => Navigator.pop(context),
                                label: const Text('Go home'),
                                icon: const Icon(Icons.repeat))
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ))),
        ));
  }
}
