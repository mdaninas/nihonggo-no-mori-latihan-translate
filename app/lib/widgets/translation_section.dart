import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TranslationSection extends StatelessWidget {
  const TranslationSection({required this.translation, super.key});

  final String translation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD6E3FA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Terjemahan',
            style: TextStyle(color: AppTheme.blue, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(translation, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
