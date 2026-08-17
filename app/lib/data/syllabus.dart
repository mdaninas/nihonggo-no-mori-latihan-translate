import '../models/question.dart';
import 'questions.dart';
import 'questions_context.dart';
import 'questions_spelling.dart';
import 'questions_synonym.dart';
import 'questions_usage.dart';

class SyllabusSection {
  const SyllabusSection({
    required this.number,
    required this.title,
    required this.questions,
  });

  final int number;
  final String title;
  final List<Question> questions;

  String get label => 'Soal $number';
  bool get hasQuestions => questions.isNotEmpty;
}

class SyllabusChapter {
  const SyllabusChapter({
    required this.roman,
    required this.title,
    required this.sections,
  });

  final String roman;
  final String title;
  final List<SyllabusSection> sections;

  String get heading => 'BAB $roman : $title';

  int get questionCount => sections.fold(0, (sum, section) => sum + section.questions.length);
}

final chapters = <SyllabusChapter>[
  SyllabusChapter(
    roman: 'I',
    title: 'Huruf & Kosakata',
    sections: [
      SyllabusSection(number: 1, title: 'Membaca Kanji', questions: questions),
      SyllabusSection(number: 2, title: 'Penulisan / Ejaan', questions: spellingQuestions),
      SyllabusSection(number: 3, title: 'Konteks Kalimat', questions: contextQuestions),
      SyllabusSection(number: 4, title: 'Sinonim / Parafrase Kata', questions: synonymQuestions),
      SyllabusSection(number: 5, title: 'Penggunaan Kata', questions: usageQuestions),
    ],
  ),
];
