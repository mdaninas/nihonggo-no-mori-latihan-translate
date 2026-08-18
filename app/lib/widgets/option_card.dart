import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_theme.dart';
import 'furigana_text.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    required this.index,
    required this.option,
    required this.showFurigana,
    required this.isSelected,
    required this.isRevealed,
    required this.isCorrect,
    required this.onTap,
    this.gloss,
    super.key,
  });

  final int index;
  final String option;
  final bool showFurigana;
  final String? gloss;
  final bool isSelected;
  final bool isRevealed;
  final bool isCorrect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isWrong = isRevealed && isSelected && !isCorrect;
    final borderColor = isCorrect && isRevealed
        ? AppTheme.sage
        : isWrong
            ? const Color(0xFFC94B4B)
            : isSelected
                ? AppTheme.blue
                : Theme.of(context).colorScheme.outline;
    final background = isCorrect && isRevealed
        ? (dark ? const Color(0xFF1F3A2E) : const Color(0xFFE9F6EF))
        : isWrong
            ? (dark ? const Color(0xFF3A2424) : const Color(0xFFFFEEEE))
            : isSelected
                ? (dark ? const Color(0xFF243044) : const Color(0xFFF0F5FF))
                : Theme.of(context).colorScheme.surface;
    const labels = ['A', 'B', 'C', 'D'];
    final parts = parseRuby(option);
    final surfaceText = parts.map((part) => part.text).join();
    final fontSize = surfaceText.length > 22 ? 15.0 : 20.0;
    final showGloss = gloss != null && gloss!.isNotEmpty;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FuriganaText(
                        parts: parts,
                        showFurigana: showFurigana,
                        fontSize: fontSize,
                      ),
                      if (showGloss) ...[
                        const SizedBox(height: 4),
                        Text(
                          gloss!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
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
