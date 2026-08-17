import 'package:flutter/material.dart';

class PracticeProgressBar extends StatelessWidget {
  const PracticeProgressBar({required this.current, required this.total, super.key});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final value = total == 0 ? 0.0 : current / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(value: value, minHeight: 8),
        ),
        const SizedBox(height: 7),
        Text(
          '$current dari $total soal dikerjakan (${(value * 100).round()}%)',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
