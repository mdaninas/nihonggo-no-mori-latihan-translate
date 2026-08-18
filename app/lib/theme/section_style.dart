import 'package:flutter/material.dart';

import 'app_theme.dart';

class SectionStyle {
  const SectionStyle({
    required this.kanji,
    required this.japaneseLabel,
    required this.accent,
    required this.wash,
    this.iconAsset,
  });

  final String kanji;
  final String japaneseLabel;
  final Color accent;
  final Color wash;
  final String? iconAsset;

  static SectionStyle of(int number) {
    switch (number) {
      case 1:
        return const SectionStyle(
          kanji: '漢',
          japaneseLabel: '漢字の読み',
          accent: AppTheme.coral,
          wash: Color(0xFFFFF1F2),
          iconAsset: 'assets/section_kanji.png',
        );
      case 2:
        return const SectionStyle(
          kanji: '書',
          japaneseLabel: '表記',
          accent: AppTheme.blue,
          wash: Color(0xFFEEF2FF),
          iconAsset: 'assets/section_spelling.png',
        );
      case 3:
        return const SectionStyle(
          kanji: '文',
          japaneseLabel: '文脈規定',
          accent: AppTheme.sage,
          wash: Color(0xFFECFDF5),
          iconAsset: 'assets/section_context.png',
        );
      case 4:
        return const SectionStyle(
          kanji: '換',
          japaneseLabel: '言い換え',
          accent: AppTheme.gold,
          wash: Color(0xFFFEF3C7),
          iconAsset: 'assets/section_synonym.png',
        );
      case 5:
        return const SectionStyle(
          kanji: '用',
          japaneseLabel: '用法',
          accent: AppTheme.plum,
          wash: Color(0xFFF3E8FF),
          iconAsset: 'assets/section_usage.png',
        );
      default:
        return const SectionStyle(
          kanji: '森',
          japaneseLabel: '練習',
          accent: AppTheme.ink,
          wash: AppTheme.mist,
        );
    }
  }

  Color washFor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? accent.withValues(alpha: 0.22) : wash;
  }
}
