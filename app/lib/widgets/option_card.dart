import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    required this.index,
    required this.option,
    required this.isSelected,
    required this.isRevealed,
    required this.isCorrect,
    required this.onTap,
    super.key,
  });

  final int index;
  final String option;
  final bool isSelected;
  final bool isRevealed;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isWrong = isRevealed && isSelected && !isCorrect;
    final borderColor = isCorrect && isRevealed
        ? AppTheme.sage
        : isWrong
            ? const Color(0xFFC94B4B)
            : isSelected
                ? AppTheme.blue
                : AppTheme.line;
    final background = isCorrect && isRevealed
        ? const Color(0xFFE9F6EF)
        : isWrong
            ? const Color(0xFFFFEEEE)
            : isSelected
                ? const Color(0xFFF0F5FF)
                : AppTheme.paper;
    const labels = ['A', 'B', 'C', 'D'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Semantics(
        button: true,
        selected: isSelected,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: isSelected || (isRevealed && isCorrect) ? 1.5 : 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: borderColor.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: Text(labels[index], style: TextStyle(color: borderColor, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: option.length > 22 ? 15 : 20,
                      height: 1.35,
                      color: AppTheme.ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isRevealed && isCorrect)
                  const Icon(Icons.check_circle_rounded, color: AppTheme.sage)
                else if (isWrong)
                  const Icon(Icons.cancel_rounded, color: Color(0xFFC94B4B)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
