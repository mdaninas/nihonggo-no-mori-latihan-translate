import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_theme.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.question, required this.isAnswered, required this.onTap, super.key});

  final Question question;
  final bool isAnswered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isAnswered ? const Color(0xFFE9F6EF) : AppTheme.mist,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: isAnswered
                    ? const Icon(Icons.check_rounded, color: AppTheme.sage)
                    : Text(
                        '${question.sourceNumber}',
                        style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.ink),
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.testedWord,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppTheme.coral),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      question.japaneseText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF98A2B3)),
            ],
          ),
        ),
      ),
    );
  }
}
