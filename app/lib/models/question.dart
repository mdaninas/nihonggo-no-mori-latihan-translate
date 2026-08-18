enum QuestionKind { kanjiReading, spelling, context, synonym, usage }

/// A fragment of Japanese text.  A fragment with [reading] is rendered as
/// ruby/furigana: the reading is visually positioned above [text].
class JapanesePart {
  const JapanesePart.text(this.text, {this.isTested = false}) : reading = null;

  const JapanesePart.furigana(this.text, this.reading, {this.isTested = false});

  final String text;
  final String? reading;
  final bool isTested;

  bool get hasFurigana => reading != null && reading!.isNotEmpty;
}

class Question {
  const Question({
    required this.id,
    required this.kind,
    required this.sourcePage,
    required this.sourceNumber,
    required this.testedWord,
    required this.japaneseParts,
    required this.translation,
    required this.options,
    required this.answerIndex,
    required this.explanation,
    this.optionGlosses,
  });

  factory Question.reading({
    required int id,
    required int sourcePage,
    required int sourceNumber,
    required String sentence,
    required String testedWord,
    required String reading,
    required String translation,
    required List<String> options,
    required int answerIndex,
    required String explanation,
    List<String>? optionGlosses,
  }) {
    return Question.item(
      id: id,
      kind: QuestionKind.kanjiReading,
      sourcePage: sourcePage,
      sourceNumber: sourceNumber,
      sentence: sentence,
      testedWord: testedWord,
      translation: translation,
      options: options,
      answerIndex: answerIndex,
      explanation: explanation,
      optionGlosses: optionGlosses,
    );
  }

  factory Question.item({
    required int id,
    required QuestionKind kind,
    required int sourcePage,
    required int sourceNumber,
    required String sentence,
    required String testedWord,
    required String translation,
    required List<String> options,
    required int answerIndex,
    required String explanation,
    List<String>? optionGlosses,
  }) {
    final parts = parseAnnotatedSentence(sentence, testedWord: testedWord);
    return Question(
      id: id,
      kind: kind,
      sourcePage: sourcePage,
      sourceNumber: sourceNumber,
      testedWord: testedWord,
      japaneseParts: parts,
      translation: translation,
      options: options,
      answerIndex: answerIndex,
      explanation: explanation,
      optionGlosses: optionGlosses,
    );
  }

  final int id;
  final QuestionKind kind;
  final int sourcePage;
  final int sourceNumber;
  final String testedWord;
  final List<JapanesePart> japaneseParts;
  final String translation;
  final List<String> options;
  final List<String>? optionGlosses;
  final int answerIndex;
  final String explanation;

  String get japaneseText => japaneseParts.map((part) => part.text).join();
  String get answer => options[answerIndex];
  String get answerSurface => stripRuby(answer);

  String get stemLabel {
    switch (kind) {
      case QuestionKind.usage:
        return 'Kata yang diuji';
      case QuestionKind.context:
        return 'Lengkapi kalimat';
      case QuestionKind.synonym:
        return 'Pilih yang artinya paling dekat';
      case QuestionKind.spelling:
        return 'Pilih kanji yang tepat';
      case QuestionKind.kanjiReading:
        return 'Baca kalimat ini';
    }
  }

  String get choicePrompt {
    switch (kind) {
      case QuestionKind.kanjiReading:
        return 'Pilih bacaan 「$testedWord」';
      case QuestionKind.spelling:
        return 'Pilih kanji untuk 「$testedWord」';
      case QuestionKind.context:
        return 'Pilih kata yang paling tepat';
      case QuestionKind.synonym:
        return 'Pilih yang paling dekat artinya';
      case QuestionKind.usage:
        return 'Pilih pemakaian yang paling tepat';
    }
  }
}

final _rubyPattern = RegExp(r'([\u4E00-\u9FFF々〆ヵヶ]+)\u005B([^\]]+)\u005D');

List<JapanesePart> parseRuby(String annotated) {
  final parts = <JapanesePart>[];
  var cursor = 0;
  for (final match in _rubyPattern.allMatches(annotated)) {
    if (match.start > cursor) {
      parts.add(JapanesePart.text(annotated.substring(cursor, match.start)));
    }
    parts.add(JapanesePart.furigana(match.group(1)!, match.group(2)!));
    cursor = match.end;
  }
  if (cursor < annotated.length) {
    parts.add(JapanesePart.text(annotated.substring(cursor)));
  }
  return parts;
}

String stripRuby(String annotated) => parseRuby(annotated).map((part) => part.text).join();

List<JapanesePart> parseAnnotatedSentence(String annotated, {required String testedWord}) {
  final raw = <JapanesePart>[];
  var cursor = 0;
  for (final match in _rubyPattern.allMatches(annotated)) {
    if (match.start > cursor) {
      raw.add(JapanesePart.text(annotated.substring(cursor, match.start)));
    }
    raw.add(JapanesePart.furigana(match.group(1)!, match.group(2)!));
    cursor = match.end;
  }
  if (cursor < annotated.length) {
    raw.add(JapanesePart.text(annotated.substring(cursor)));
  }

  var testedIndex = -1;
  for (var i = 0; i < raw.length; i++) {
    final part = raw[i];
    if (part.hasFurigana && testedWord.startsWith(part.text)) {
      if (testedIndex < 0 || part.text.length > raw[testedIndex].text.length) {
        testedIndex = i;
      }
    }
  }

  if (testedIndex < 0 && testedWord.isNotEmpty) {
    for (var i = 0; i < raw.length; i++) {
      if (raw[i].hasFurigana) continue;
      final at = raw[i].text.indexOf(testedWord);
      if (at < 0) continue;
      final before = raw[i].text.substring(0, at);
      final after = raw[i].text.substring(at + testedWord.length);
      raw.removeAt(i);
      if (after.isNotEmpty) raw.insert(i, JapanesePart.text(after));
      raw.insert(i, JapanesePart.text(testedWord, isTested: true));
      if (before.isNotEmpty) raw.insert(i, JapanesePart.text(before));
      return raw;
    }
  }

  return [
    for (var i = 0; i < raw.length; i++)
      if (raw[i].hasFurigana)
        JapanesePart.furigana(raw[i].text, raw[i].reading, isTested: i == testedIndex)
      else
        JapanesePart.text(raw[i].text, isTested: i == testedIndex),
  ];
}
