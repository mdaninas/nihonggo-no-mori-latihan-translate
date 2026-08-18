import 'package:flutter/material.dart';

import '../models/learner_stats.dart';
import '../theme/app_theme.dart';

enum MascotPose { hero, happy, zen, determined, study, eat, sleep }

class MoriMascot extends StatelessWidget {
  const MoriMascot({this.pose = MascotPose.hero, this.size = 88, super.key});

  final MascotPose pose;
  final double size;

  static const _assets = {
    MascotPose.hero: 'assets/kapizamurai_hero.png',
    MascotPose.happy: 'assets/kapizamurai_happy.png',
    MascotPose.zen: 'assets/kapizamurai_zen.png',
    MascotPose.determined: 'assets/kapizamurai_determined.png',
    MascotPose.study: 'assets/kapizamurai_study.png',
    MascotPose.eat: 'assets/kapizamurai_eat.png',
    MascotPose.sleep: 'assets/kapizamurai_sleep.png',
  };

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _assets[pose]!,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: AppTheme.mist, shape: BoxShape.circle),
          child: Text('森', style: TextStyle(fontSize: size * 0.42, fontWeight: FontWeight.w800, color: AppTheme.sage)),
        );
      },
    );
  }
}

void showAnswerToast(BuildContext context, Award award) {
  if (!award.firstAnswer) return;
  final message = award.correct
      ? (award.leveledUp ? 'Naik ke Level ${award.level}!' : 'Hebat! +${award.xpGained} XP')
      : 'Belum tepat';
  final pose = award.correct ? MascotPose.happy : MascotPose.determined;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1600),
        content: Row(
          children: [
            MoriMascot(pose: pose, size: 36),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
}
