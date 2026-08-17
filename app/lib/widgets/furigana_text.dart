import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_theme.dart';

class FuriganaText extends StatelessWidget {
  const FuriganaText({
    required this.parts,
    required this.showFurigana,
    this.fontSize = 24,
    super.key,
  });

  final List<JapanesePart> parts;
  final bool showFurigana;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: fontSize,
          height: 1.55,
          color: AppTheme.ink,
        );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        for (final part in parts)
          if (showFurigana && part.hasFurigana)
            _RubyToken(
              text: part.text,
              reading: part.reading!,
              fontSize: fontSize,
              highlight: part.isTested,
            )
          else
            Text(
              part.text,
              style: part.isTested
                  ? baseStyle.copyWith(color: AppTheme.coral, fontWeight: FontWeight.w800)
                  : baseStyle,
            ),
      ],
    );
  }
}

class _RubyToken extends StatelessWidget {
  const _RubyToken({
    required this.text,
    required this.reading,
    required this.fontSize,
    required this.highlight,
  });

  final String text;
  final String reading;
  final double fontSize;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final kanjiColor = highlight ? AppTheme.coral : AppTheme.ink;
    return Padding(
      padding: const EdgeInsets.only(top: 2, right: 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            reading,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: highlight ? AppTheme.coral : AppTheme.blue,
              fontSize: fontSize * .4,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            text,
            style: TextStyle(
              color: kanjiColor,
              fontSize: fontSize,
              height: 1.05,
              fontWeight: highlight ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
