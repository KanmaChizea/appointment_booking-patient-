import 'package:flutter/material.dart';

class FailedState extends StatelessWidget {
  const FailedState({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, size: 48),
        const SizedBox(height: 16),
        const Text('Could not fetch appointment'),
        ElevatedButton(
            onPressed: () => onPressed, child: const Text('Try again'))
      ],
    );
  }
}
