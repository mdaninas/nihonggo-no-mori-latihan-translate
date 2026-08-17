import '../models/question.dart';
import 'questions.dart';

class Chapter {
  const Chapter({
    required this.roman,
    required this.title,
    required this.startId,
    required this.endId,
  });

  final String roman;
  final String title;
  final int startId;
  final int endId;

  String get heading => 'BAB $roman : $title';

  List<Question> get items => questions.where((question) => question.id >= startId && question.id <= endId).toList();

  int exampleNumber(Question question) => question.id - startId + 1;

  bool contains(Question question) => question.id >= startId && question.id <= endId;
}

Chapter? chapterFor(Question question) {
  for (final chapter in chapters) {
    if (chapter.contains(question)) return chapter;
  }
  return null;
}

/// Textbook-style grouping for the current N3 reading bank.
final chapters = <Chapter>[
  const Chapter(roman: 'I', title: 'Huruf & Kosakata', startId: 1, endId: 40),
  const Chapter(roman: 'II', title: 'Kata Kerja', startId: 41, endId: 60),
  const Chapter(roman: 'III', title: 'Kata Sifat', startId: 61, endId: 90),
];
