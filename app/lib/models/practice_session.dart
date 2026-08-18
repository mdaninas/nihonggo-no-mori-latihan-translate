import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'learner_stats.dart';

class PracticeSession extends ChangeNotifier {
  PracticeSession({LearnerStats? stats}) : _stats = stats ?? LearnerStats();

  final LearnerStats _stats;
  LearnerStats get stats => _stats;

  int? selectedAnswer(int questionId) => _stats.answers[questionId];
  bool isRevealed(int questionId) => _stats.revealed.contains(questionId);
  ThemeMode get themeMode => _stats.darkMode ? ThemeMode.dark : ThemeMode.light;

  Award selectAnswer(int questionId, int optionIndex, {required bool correct, DateTime? now}) {
    final award = _stats.recordAnswer(questionId, optionIndex, now ?? DateTime.now(), correct: correct);
    notifyListeners();
    persist();
    return award;
  }

  void revealAnswer(int questionId) {
    if (_stats.revealed.add(questionId)) {
      notifyListeners();
      persist();
    }
  }

  void toggleTheme() {
    _stats.darkMode = !_stats.darkMode;
    notifyListeners();
    persist();
  }

  void markTipsSeen({DateTime? now}) {
    _stats.markTipsSeen(now ?? DateTime.now());
    notifyListeners();
    persist();
  }

  Future<void> persist() async {
    try {
      final file = await _learnerFile();
      await file.writeAsString(jsonEncode(_stats.toJson()));
    } catch (_) {}
  }

  static Future<PracticeSession> load() async {
    try {
      final file = await _learnerFile();
      if (await file.exists()) {
        final json = jsonDecode(await file.readAsString());
        if (json is Map<String, dynamic>) {
          return PracticeSession(stats: LearnerStats.fromJson(json));
        }
      }
    } catch (_) {}
    return PracticeSession();
  }
}

Future<File> _learnerFile() async {
  if (Platform.isAndroid) {
    final dir = Directory('/data/user/0/com.example.nihongo_no_mori/app_flutter');
    if (!await dir.exists()) await dir.create(recursive: true);
    return File('${dir.path}/learner.json');
  }
  final home = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'] ?? '.';
  final dir = Directory('$home${Platform.pathSeparator}.nihongo_no_mori');
  if (!await dir.exists()) await dir.create(recursive: true);
  return File('${dir.path}${Platform.pathSeparator}learner.json');
}
