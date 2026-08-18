import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/syllabus.dart';
import '../models/practice_session.dart';
import '../theme/app_theme.dart';
import '../theme/section_style.dart';
import '../widgets/mascot.dart';
import '../widgets/section_icon.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({required this.session, super.key});

  final PracticeSession session;

  int _answeredIn(SyllabusSection section) {
    return section.questions.where((question) => session.selectedAnswer(question.id) != null).length;
  }

  Future<void> _editName(BuildContext context) async {
    final controller = TextEditingController(text: session.stats.displayName);
    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nama profil'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLength: 24,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'Pembelajar N3',
              counterText: '',
            ),
            onSubmitted: (value) => Navigator.of(context).pop(value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              style: FilledButton.styleFrom(minimumSize: const Size(88, 40)),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (name == null) return;
    HapticFeedback.selectionClick();
    session.setDisplayName(name);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final stats = session.stats;
    final sections = chapters.expand((chapter) => chapter.sections).toList();
    final total = sections.fold(0, (sum, section) => sum + section.questions.length);
    final answered = sections.fold(0, (sum, section) => sum + _answeredIn(section));
    final outline = Theme.of(context).colorScheme.outline;
    final surface = Theme.of(context).colorScheme.surface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        const Center(child: MoriMascot(pose: MascotPose.hero, size: 128)),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () => _editName(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    stats.profileName,
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.edit_rounded, size: 18, color: Theme.of(context).colorScheme.onSurface),
              ],
            ),
          ),
        ),
        Text(
          'Latihan harian N3 · versi 1.0.0',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: outline),
          ),
          child: Row(
            children: [
              _Stat(icon: Icons.local_fire_department_rounded, color: AppTheme.coral, label: 'Streak', value: '${stats.displayStreak(now)} hari'),
              _Stat(icon: Icons.star_rounded, color: AppTheme.gold, label: 'XP', value: '${stats.xp}'),
              _Stat(icon: Icons.shield_rounded, color: AppTheme.blue, label: 'Level', value: '${stats.level}'),
              const _Stat(icon: Icons.gps_fixed_rounded, color: AppTheme.coral, label: 'Target', value: 'N3'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Soal dikerjakan', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text('$answered / $total', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : answered / total,
                  minHeight: 8,
                  color: AppTheme.coral,
                  backgroundColor: Theme.of(context).colorScheme.outline.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...sections.map((section) {
          final look = SectionStyle.of(section.number);
          final done = _answeredIn(section);
          final count = section.questions.length;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: outline),
              ),
              child: Row(
                children: [
                  SectionIcon(style: look, size: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(section.title, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Text(
                    '$done / $count',
                    style: TextStyle(color: look.accent, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 6),
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          title: const Text('Mode gelap'),
          subtitle: Text(stats.darkMode ? 'Aktif' : 'Nonaktif'),
          secondary: Icon(stats.darkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
          value: stats.darkMode,
          onChanged: (_) {
            HapticFeedback.selectionClick();
            session.toggleTheme();
          },
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(label, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 11, fontWeight: FontWeight.w700)),
          Text(value, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
