import 'package:flutter/material.dart';

import '../data/syllabus.dart';
import '../models/practice_session.dart';
import '../theme/app_theme.dart';
import '../theme/section_style.dart';
import 'question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.session, super.key});

  final PracticeSession session;

  void _openSection(BuildContext context, SyllabusSection section) {
    if (!section.hasQuestions) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('${section.label} belum ada soal.')));
      return;
    }
    final firstPending = section.questions.indexWhere((question) => session.selectedAnswer(question.id) == null);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuestionScreen(
          session: session,
          section: section,
          initialIndex: firstPending == -1 ? 0 : firstPending,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: session,
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
              children: [
                const _TopBar(),
                const SizedBox(height: 20),
                for (final chapter in chapters) ...[
                  _ForestHero(chapter: chapter),
                  const SizedBox(height: 16),
                  const Text(
                    'Pilih sub-bab. Progres masing-masing terpisah.',
                    style: TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                  for (final section in chapter.sections) ...[
                    _SectionCard(
                      section: section,
                      answered: section.questions.where((question) => session.selectedAnswer(question.id) != null).length,
                      onTap: () => _openSection(context, section),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.coral,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x33E36D58), blurRadius: 12, offset: Offset(0, 6))],
          ),
          child: const Text('森', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nihongo no Mori', style: Theme.of(context).textTheme.titleMedium),
              const Text('Latihan baca N3', style: TextStyle(fontSize: 12, color: AppTheme.muted, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.mist,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: AppTheme.line),
          ),
          child: const Text('JLPT N3', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: AppTheme.ink)),
        ),
      ],
    );
  }
}

class _ForestHero extends StatelessWidget {
  const _ForestHero({required this.chapter});

  final SyllabusChapter chapter;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 168,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B2740), Color(0xFF24324A), Color(0xFF314A3D)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(right: -18, top: -28, child: Text('森', style: TextStyle(fontSize: 168, height: 1, color: Color(0x22FFFFFF), fontWeight: FontWeight.w800))),
            const Positioned(left: 22, bottom: -10, child: Text('語', style: TextStyle(fontSize: 72, color: Color(0x14FFFFFF), fontWeight: FontWeight.w800))),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text('BAB ${chapter.roman} · 文字・語彙', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                  ),
                  const Spacer(),
                  Text(
                    chapter.title,
                    style: const TextStyle(color: Colors.white, fontSize: 26, height: 1.15, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Lima jenis latihan. Ketuk satu sub-bab untuk mulai.',
                    style: TextStyle(color: Color(0xFFD7E0EE), fontSize: 13, height: 1.35, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.section,
    required this.answered,
    required this.onTap,
  });

  final SyllabusSection section;
  final int answered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final look = SectionStyle.of(section.number);
    final total = section.questions.length;
    final progress = total == 0 ? 0.0 : answered / total;
    final status = total == 0
        ? 'Kosong'
        : answered == 0
            ? 'Mulai'
            : answered >= total
                ? 'Selesai'
                : 'Lanjutkan';
    final statusColor = answered >= total && total > 0 ? AppTheme.sage : look.accent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: AppTheme.paper,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppTheme.line),
            boxShadow: const [BoxShadow(color: Color(0x0F172033), blurRadius: 16, offset: Offset(0, 8))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Column(
              children: [
                Container(height: 4, width: double.infinity, color: look.accent),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 14, 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: look.wash, borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              look.kanji,
                              style: TextStyle(color: look.accent, fontSize: 24, fontWeight: FontWeight.w800, height: 1),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${section.label}  ·  ${look.japaneseLabel}',
                                  style: TextStyle(color: look.accent, fontWeight: FontWeight.w800, fontSize: 12),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  section.title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: Color(0xFF98A2B3)),
                        ],
                      ),
                      if (total > 0) ...[
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  color: look.accent,
                                  backgroundColor: look.wash,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '$answered / $total',
                              style: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(color: statusColor, fontWeight: FontWeight.w800, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
