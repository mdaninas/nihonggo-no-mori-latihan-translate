import 'package:flutter/material.dart';

import '../theme/section_style.dart';

class SectionIcon extends StatelessWidget {
  const SectionIcon({
    required this.style,
    this.size = 52,
    super.key,
  });

  final SectionStyle style;
  final double size;

  @override
  Widget build(BuildContext context) {
    final asset = style.iconAsset;
    if (asset == null) {
      return _kanjiFallback(context);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _kanjiFallback(context),
      ),
    );
  }

  Widget _kanjiFallback(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: style.washFor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        style.kanji,
        style: TextStyle(
          color: style.accent,
          fontSize: size * 0.46,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}
