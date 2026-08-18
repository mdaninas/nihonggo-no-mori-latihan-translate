import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/syllabus.dart';
import '../models/practice_session.dart';
import '../theme/app_theme.dart';
import '../theme/section_style.dart';
import '../widgets/answer_section.dart';
import '../widgets/japanese_text.dart';
import '../widgets/mascot.dart';
import '../widgets/option_card.dart';
import '../widgets/section_icon.dart';
import '../widgets/translation_section.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    required this.session,
    required this.section,
    required this.initialIndex,
    super.key,
  });

  final PracticeSession session;
  final SyllabusSection section;
  final int initialIndex;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late int _index;
  int? _draftChoice;
  final _scrollController = ScrollController();
  bool _showFurigana = false;
  bool _showTranslation = false;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.section.questions.length - 1).toInt();
    _draftChoice = widget.session.selectedAnswer(widget.section.questions[_index].id);
  }

  void _changeQuestion(int nextIndex) {
    if (nextIndex < 0 || nextIndex >= widget.section.questions.length) return;
    setState(() {
      _index = nextIndex;
      _draftChoice = widget.session.selectedAnswer(widget.section.questions[nextIndex].id);
    });
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 180), curve: Curves.easeOut);
  }

  void _submit(BuildContext context) {
    final question = widget.section.questions[_index];
    final choice = _draftChoice;
    if (choice == null || widget.session.selectedAnswer(question.id) != null) return;
    HapticFeedback.mediumImpact();
    final award = widget.session.selectAnswer(question.id, choice);
    widget.session.revealAnswer(question.id);
    showXpToast(context, award);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.section.questions;
    final question = items[_index];
    final total = items.length;
    final look = SectionStyle.of(widget.section.number);
    return AnimatedBuilder(
      animation: widget.session,
      builder: (context, _) {
        final submittedAnswer = widget.session.selectedAnswer(question.id);
        final submitted = submittedAnswer != null;
        final selectedAnswer = submittedAnswer ?? _draftChoice;
        final isRevealed = submitted || widget.session.isRevealed(question.id);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                SectionIcon(style: look, size: 36),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.section.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text(
                        '${widget.section.label} · ${_index + 1} / $total',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Daftar soal',
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.format_list_bulleted_rounded),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: (_index + 1) / total,
                    minHeight: 6,
                    color: look.accent,
                    backgroundColor: look.wash,
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  children: [
                    JapaneseText(question: question, showFurigana: _showFurigana),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              FilterChip(
                                avatar: const Text('あ', style: TextStyle(fontWeight: FontWeight.w800)),
                                label: const Text('Furigana'),
                                selected: _showFurigana,
                                showCheckmark: false,
                                onSelected: (selected) => setState(() => _showFurigana = selected),
                              ),
                              FilterChip(
                                avatar: const Icon(Icons.translate_rounded, size: 18),
                                label: const Text('Terjemahan'),
                                selected: _showTranslation,
                                showCheckmark: false,
                                onSelected: (selected) => setState(() => _showTranslation = selected),
                              ),
                            ],
                          ),
                        ),
                        MoriMascot(
                          pose: !submitted
                              ? MascotPose.study
                              : submittedAnswer == question.answerIndex
                                  ? MascotPose.happy
                                  : MascotPose.determined,
                          size: 64,
                        ),
                      ],
                    ),
                    if (_showTranslation) ...[
                      const SizedBox(height: 12),
                      TranslationSection(translation: question.translation),
                    ],
                    const SizedBox(height: 28),
                    Text(
                      question.choicePrompt,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    for (var optionIndex = 0; optionIndex < question.options.length; optionIndex++)
                      OptionCard(
                        index: optionIndex,
                        option: question.options[optionIndex],
                        showFurigana: _showFurigana,
                        gloss: _showTranslation ? (question.optionGlosses?[optionIndex]) : null,
                        isSelected: selectedAnswer == optionIndex,
                        isRevealed: isRevealed && submitted,
                        isCorrect: question.answerIndex == optionIndex,
                        onTap: submitted
                            ? null
                            : () {
                                HapticFeedback.selectionClick();
                                setState(() => _draftChoice = optionIndex);
                              },
                      ),
                    const SizedBox(height: 4),
                    if (submitted)
                      AnswerSection(question: question, selectedAnswer: submittedAnswer)
                    else if (!isRevealed)
                      OutlinedButton.icon(
                        onPressed: () => widget.session.revealAnswer(question.id),
                        icon: const Icon(Icons.visibility_outlined),
                        label: const Text('Lihat jawaban'),
                      )
                    else
                      AnswerSection(question: question, selectedAnswer: selectedAnswer),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline)),
                    boxShadow: const [BoxShadow(color: Color(0x0F172033), blurRadius: 12, offset: Offset(0, -4))],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _index == 0 ? null : () => _changeQuestion(_index - 1),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: const Text('Sebelumnya'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: submitted
                            ? FilledButton.icon(
                                onPressed: _index == total - 1
                                    ? () => Navigator.of(context).pop()
                                    : () => _changeQuestion(_index + 1),
                                icon: Icon(_index == total - 1 ? Icons.check_rounded : Icons.arrow_forward_rounded),
                                label: Text(_index == total - 1 ? 'Selesai' : 'Berikutnya'),
                                iconAlignment: IconAlignment.end,
                                style: FilledButton.styleFrom(backgroundColor: look.accent),
                              )
                            : FilledButton.icon(
                                onPressed: _draftChoice == null ? null : () => _submit(context),
                                icon: const Icon(Icons.send_rounded),
                                label: const Text('Kirim'),
                                iconAlignment: IconAlignment.end,
                                style: FilledButton.styleFrom(backgroundColor: look.accent),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
