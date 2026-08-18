import 'package:flutter/material.dart';

import '../data/syllabus.dart';
import '../models/learner_stats.dart';
import '../models/practice_session.dart';
import '../theme/app_theme.dart';
import '../theme/section_style.dart';
import '../widgets/mascot.dart';
import '../widgets/section_icon.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({
    required this.session,
    required this.onOpenSection,
    super.key,
  });

  final PracticeSession session;
  final void Function(SyllabusSection section) onOpenSection;

  int _answeredIn(SyllabusSection section) {
    return section.questions.where((question) => session.selectedAnswer(question.id) != null).length;
  }

  int _correctIn(SyllabusSection section) {
    return section.questions.where((question) {
      final choice = session.selectedAnswer(question.id);
      return choice != null && choice == question.answerIndex;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final stats = session.stats;
    final sections = chapters.expand((chapter) => chapter.sections).toList();
    final total = sections.fold(0, (sum, section) => sum + section.questions.length);
    final answered = sections.fold(0, (sum, section) => sum + _answeredIn(section));
    final correct = sections.fold(0, (sum, section) => sum + _correctIn(section));
    final overall = total == 0 ? 0.0 : answered / total;
    final accuracy = answered == 0 ? 0.0 : correct / answered;
    final outline = Theme.of(context).colorScheme.outline;
    final surface = Theme.of(context).colorScheme.surface;
    final pose = answered == 0
        ? MascotPose.study
        : accuracy >= 0.7
            ? MascotPose.happy
            : MascotPose.determined;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Text('Progress', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(
          'Progres tiap sub-bab terpisah.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: outline),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: overall,
                      strokeWidth: 8,
                      color: AppTheme.coral,
                      backgroundColor: outline.withValues(alpha: 0.35),
                    ),
                    Text(
                      '${(overall * 100).round()}%',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$answered / $total soal dikerjakan', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(
                      answered == 0
                          ? 'Belum ada jawaban. Mulai dari Beranda.'
                          : 'Benar $correct dari $answered (${(accuracy * 100).round()}%)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    MoriMascot(pose: pose, size: 52),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Level ${stats.level}', style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  Text(
                    '${stats.xpIntoLevel} / ${LearnerStats.xpPerLevel} XP',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: stats.levelProgress,
                  minHeight: 8,
                  color: AppTheme.coral,
                  backgroundColor: outline.withValues(alpha: 0.35),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Streak ${stats.displayStreak(now)} hari · ${stats.xp} XP total',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text('Per sub-bab', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        for (final section in sections) ...[
          _SectionProgressCard(
            section: section,
            answered: _answeredIn(section),
            correct: _correctIn(section),
            onTap: () => onOpenSection(section),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _SectionProgressCard extends StatelessWidget {
  const _SectionProgressCard({
    required this.section,
    required this.answered,
    required this.correct,
    required this.onTap,
  });

  final SyllabusSection section;
  final int answered;
  final int correct;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final look = SectionStyle.of(section.number);
    final total = section.questions.length;
    final progress = total == 0 ? 0.0 : answered / total;
    final percent = (progress * 100).round();
    final wash = look.washFor(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SectionIcon(style: look, size: 44),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(section.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          answered == 0
                              ? 'Belum dimulai'
                              : 'Benar $correct · $answered / $total',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: TextStyle(color: look.accent, fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  color: look.accent,
                  backgroundColor: wash,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
