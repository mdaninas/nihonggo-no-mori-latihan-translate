import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TranslationSection extends StatelessWidget {
  const TranslationSection({required this.translation, super.key});

  final String translation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark ? colorScheme.surface : const Color(0xFFF0F5FF);
    final borderColor = isDark ? colorScheme.outline : const Color(0xFFD6E3FA);
    final bodyStyle = theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Terjemahan',
            style: TextStyle(color: AppTheme.blue, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(translation, style: bodyStyle),
        ],
      ),
    );
  }
}
