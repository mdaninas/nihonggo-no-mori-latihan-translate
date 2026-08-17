import 'package:flutter/foundation.dart';

class PracticeSession extends ChangeNotifier {
  final Map<int, int> _answers = {};
  final Set<int> _revealed = {};

  int? selectedAnswer(int questionId) => _answers[questionId];
  bool isRevealed(int questionId) => _revealed.contains(questionId);
  int get answeredCount => _answers.length;

  void selectAnswer(int questionId, int optionIndex) {
    _answers[questionId] = optionIndex;
    notifyListeners();
  }

  void revealAnswer(int questionId) {
    if (_revealed.add(questionId)) notifyListeners();
  }
}
