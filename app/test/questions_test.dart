import 'package:flutter_test/flutter_test.dart';
import 'package:nihongo_no_mori/data/questions.dart';
import 'package:nihongo_no_mori/data/syllabus.dart';
import 'package:nihongo_no_mori/models/learner_stats.dart';

void main() {
  test('all transcribed questions have valid choices and answer indexes', () {
    expect(questions, hasLength(90));
    for (final question in questions) {
      expect(question.options, hasLength(4));
      expect(question.answerIndex, inInclusiveRange(0, question.options.length - 1));
      expect(question.japaneseText, isNotEmpty);
      expect(question.translation, isNotEmpty);
      expect(question.sourcePage, greaterThan(0));
      expect(question.japaneseText.contains('['), isFalse);
      expect(question.japaneseParts.where((part) => part.hasFurigana), isNotEmpty);
      expect(question.japaneseParts.where((part) => part.isTested), isNotEmpty);
    }
  });

  test('BAB I lists the five vocabulary sub-sections', () {
    expect(chapters, hasLength(1));
    expect(chapters.first.heading, 'BAB I : Huruf & Kosakata');
    expect(chapters.first.sections.map((section) => section.title), [
      'Membaca Kanji',
      'Penulisan / Ejaan',
      'Konteks Kalimat',
      'Sinonim / Parafrase Kata',
      'Penggunaan Kata',
    ]);
    expect(chapters.first.sections.map((section) => section.questions.length), [90, 70, 117, 50, 54]);
    final ids = <int>{};
    for (final section in chapters.first.sections) {
      expect(section.hasQuestions, isTrue);
      for (final question in section.questions) {
        expect(question.options, hasLength(4));
        expect(question.answerIndex, inInclusiveRange(0, 3));
        expect(question.japaneseText.contains('['), isFalse);
        expect(ids.add(question.id), isTrue, reason: 'duplicate id ${question.id}');
      }
    }
  });

  test('first correct answers grant XP and later changes do not', () {
    final stats = LearnerStats();
    final day = DateTime(2026, 8, 17);
    final first = stats.recordAnswer(1, 0, day, correct: true);
    expect(first.xpGained, 10);
    expect(first.firstAnswer, isTrue);
    expect(first.correct, isTrue);
    expect(stats.xp, 10);
    expect(stats.level, 1);
    final again = stats.recordAnswer(1, 2, day, correct: true);
    expect(again.xpGained, 0);
    expect(stats.xp, 10);
    expect(stats.answers[1], 2);
  });

  test('first wrong answer grants no XP and stores the choice', () {
    final stats = LearnerStats();
    final day = DateTime(2026, 8, 17);
    final wrong = stats.recordAnswer(1, 2, day, correct: false);
    expect(wrong.xpGained, 0);
    expect(wrong.firstAnswer, isTrue);
    expect(wrong.correct, isFalse);
    expect(stats.xp, 0);
    expect(stats.streakDays, 0);
    expect(stats.answers[1], 2);
  });

  test('correcting after a wrong first answer does not grant XP', () {
    final stats = LearnerStats();
    final day = DateTime(2026, 8, 17);
    stats.recordAnswer(1, 2, day, correct: false);
    final retry = stats.recordAnswer(1, 0, day, correct: true);
    expect(retry.xpGained, 0);
    expect(retry.firstAnswer, isFalse);
    expect(stats.xp, 0);
    expect(stats.answers[1], 0);
  });

  test('level increases after 100 XP and streak continues the next day', () {
    final stats = LearnerStats();
    final day = DateTime(2026, 8, 17);
    Award? last;
    for (var i = 0; i < 10; i++) {
      last = stats.recordAnswer(i + 1, 0, day, correct: true);
    }
    expect(stats.xp, 100);
    expect(last!.leveledUp, isTrue);
    expect(stats.level, 2);
    expect(stats.displayStreak(day), 1);
    stats.recordAnswer(20, 0, day.add(const Duration(days: 1)), correct: true);
    expect(stats.displayStreak(day.add(const Duration(days: 1))), 2);
    expect(stats.displayStreak(day.add(const Duration(days: 3))), 0);
  });
}
