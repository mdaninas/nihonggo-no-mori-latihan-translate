class Award {
  const Award({
    required this.xpGained,
    required this.leveledUp,
    required this.level,
    required this.firstAnswer,
    required this.correct,
  });

  final int xpGained;
  final bool leveledUp;
  final int level;
  final bool firstAnswer;
  final bool correct;
}

class LearnerStats {
  LearnerStats({
    this.xp = 0,
    this.streakDays = 0,
    this.lastPracticeDay,
    this.darkMode = false,
    this.lastTipsDay,
    this.displayName = '',
    Map<int, int>? answers,
    Set<int>? revealed,
  })  : answers = answers ?? <int, int>{},
        revealed = revealed ?? <int>{};

  static const xpPerAnswer = 10;
  static const xpPerLevel = 100;

  int xp;
  int streakDays;
  String? lastPracticeDay;
  bool darkMode;
  String? lastTipsDay;
  String displayName;
  final Map<int, int> answers;
  final Set<int> revealed;

  String get profileName {
    final name = displayName.trim();
    return name.isEmpty ? 'Pembelajar N3' : name;
  }

  int get level => xp ~/ xpPerLevel + 1;
  int get xpIntoLevel => xp % xpPerLevel;
  double get levelProgress => xpIntoLevel / xpPerLevel;

  int displayStreak(DateTime now) {
    final today = dayKey(now);
    final yesterday = dayKey(now.subtract(const Duration(days: 1)));
    if (lastPracticeDay == today || lastPracticeDay == yesterday) return streakDays;
    return 0;
  }

  bool hasUnseenTips(DateTime now) => lastTipsDay != dayKey(now);

  void markTipsSeen(DateTime now) => lastTipsDay = dayKey(now);

  Award recordAnswer(int questionId, int optionIndex, DateTime now, {required bool correct}) {
    final first = !answers.containsKey(questionId);
    answers[questionId] = optionIndex;
    var gained = 0;
    var leveled = false;
    if (first && correct) {
      final before = level;
      xp += xpPerAnswer;
      gained = xpPerAnswer;
      leveled = level > before;
      touchStreak(now);
    }
    return Award(
      xpGained: gained,
      leveledUp: leveled,
      level: level,
      firstAnswer: first,
      correct: correct,
    );
  }

  void touchStreak(DateTime now) {
    final today = dayKey(now);
    if (lastPracticeDay == today) return;
    if (lastPracticeDay == dayKey(now.subtract(const Duration(days: 1)))) {
      streakDays += 1;
    } else {
      streakDays = 1;
    }
    lastPracticeDay = today;
  }

  static String dayKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'streakDays': streakDays,
        'lastPracticeDay': lastPracticeDay,
        'darkMode': darkMode,
        'lastTipsDay': lastTipsDay,
        'displayName': displayName,
        'answers': answers.map((key, value) => MapEntry(key.toString(), value)),
        'revealed': revealed.toList(),
      };

  factory LearnerStats.fromJson(Map<String, dynamic> json) {
    final rawAnswers = json['answers'];
    final answers = <int, int>{};
    if (rawAnswers is Map) {
      for (final entry in rawAnswers.entries) {
        answers[int.parse(entry.key.toString())] = entry.value as int;
      }
    }
    final rawRevealed = json['revealed'];
    final revealed = <int>{};
    if (rawRevealed is List) {
      for (final id in rawRevealed) {
        revealed.add(id as int);
      }
    }
    return LearnerStats(
      xp: json['xp'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 0,
      lastPracticeDay: json['lastPracticeDay'] as String?,
      darkMode: json['darkMode'] as bool? ?? false,
      lastTipsDay: json['lastTipsDay'] as String?,
      displayName: json['displayName'] as String? ?? '',
      answers: answers,
      revealed: revealed,
    );
  }
}
