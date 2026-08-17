import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_theme.dart';
import 'furigana_text.dart';

class JapaneseText extends StatelessWidget {
  const JapaneseText({
    required this.question,
    required this.showFurigana,
    super.key,
  });

  final Question question;
  final bool showFurigana;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: question.japaneseText,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        decoration: BoxDecoration(
          color: AppTheme.paper,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppTheme.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.stemLabel,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            FuriganaText(
              parts: question.japaneseParts,
              showFurigana: showFurigana,
              fontSize: 26,
            ),
          ],
        ),
      ),
    );
  }
}
