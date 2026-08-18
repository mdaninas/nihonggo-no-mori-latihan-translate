import 'package:flutter/material.dart';

import '../models/question.dart';

class AnswerSection extends StatelessWidget {
  const AnswerSection({required this.question, required this.selectedAnswer, super.key});

  final Question question;
  final int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedAnswer == question.answerIndex;
    final response = selectedAnswer == null
        ? 'Jawaban yang benar'
        : isCorrect
            ? 'Jawabanmu benar!'
            : 'Belum tepat, perhatikan bacaannya.';
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isCorrect
            ? (dark ? const Color(0xFF1F3A2E) : const Color(0xFFE9F6EF))
            : (dark ? const Color(0xFF3A2F1F) : const Color(0xFFFFF5E9)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(response, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('Jawaban: ${String.fromCharCode(65 + question.answerIndex)}. ${question.answerSurface}'),
          const SizedBox(height: 8),
          Text(
            question.explanation,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
