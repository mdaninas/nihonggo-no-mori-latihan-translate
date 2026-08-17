import 'package:flutter_test/flutter_test.dart';
import 'package:nihongo_no_mori/data/questions.dart';
import 'package:nihongo_no_mori/data/syllabus.dart';

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
}
