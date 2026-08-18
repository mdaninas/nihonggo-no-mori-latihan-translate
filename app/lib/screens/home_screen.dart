import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/motivation.dart';
import '../data/syllabus.dart';
import '../models/learner_stats.dart';
import '../models/practice_session.dart';
import '../theme/app_theme.dart';
import '../theme/section_style.dart';
import '../widgets/mascot.dart';
import '../widgets/section_icon.dart';
import 'placeholder_tab.dart';
import 'question_screen.dart';

enum _SectionSort { syllabus, title, progress }

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.session, super.key});

  final PracticeSession session;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  _SectionSort _sort = _SectionSort.syllabus;

  PracticeSession get session => widget.session;

  void _openSection(BuildContext context, SyllabusSection section) {
    HapticFeedback.selectionClick();
    if (!section.hasQuestions) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('${section.label} belum ada soal.')));
      return;
    }
    final firstPending = section.questions.indexWhere((question) => session.selectedAnswer(question.id) == null);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuestionScreen(
          session: session,
          section: section,
          initialIndex: firstPending == -1 ? 0 : firstPending,
        ),
      ),
    );
  }

  void _openFirstSection(BuildContext context) {
    for (final chapter in chapters) {
      for (final section in chapter.sections) {
        if (section.hasQuestions) {
          _openSection(context, section);
          return;
        }
      }
    }
  }

  int _answeredCount(SyllabusSection section) {
    return section.questions.where((question) => session.selectedAnswer(question.id) != null).length;
  }

  double _sectionProgress(SyllabusSection section) {
    final total = section.questions.length;
    if (total == 0) return 0;
    return _answeredCount(section) / total;
  }

  List<SyllabusSection> _sortedSections(List<SyllabusSection> sections) {
    final copy = List<SyllabusSection>.from(sections);
    switch (_sort) {
      case _SectionSort.syllabus:
        copy.sort((a, b) => a.number.compareTo(b.number));
      case _SectionSort.title:
        copy.sort((a, b) => a.title.compareTo(b.title));
      case _SectionSort.progress:
        copy.sort((a, b) => _sectionProgress(a).compareTo(_sectionProgress(b)));
    }
    return copy;
  }

  void _onNavTap(int index) {
    HapticFeedback.selectionClick();
    if (index == 2) {
      _openFirstSection(context);
      return;
    }
    setState(() => _selectedIndex = index);
  }

  Future<void> _openTips(BuildContext context, DateTime now) async {
    session.markTipsSeen(now: now);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MoriMascot(pose: MascotPose.zen, size: 108),
              const SizedBox(height: 8),
              Text('Kapizamurai', style: Theme.of(context).textTheme.titleLarge),
              const Text('カピ侍', style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.coral)),
              const SizedBox(height: 8),
              Text('Pesan hari ini', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(dailyMessageFor(now), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text(
                'Streak ${session.stats.displayStreak(now)} hari · Level ${session.stats.level}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: session,
      builder: (context, _) {
        final now = DateTime.now();
        final hasUnseenTips = session.stats.hasUnseenTips(now);

        return Scaffold(
          drawer: _AppDrawer(
            darkMode: session.stats.darkMode,
            onToggleTheme: session.toggleTheme,
          ),
          body: SafeArea(
            child: switch (_selectedIndex) {
              1 => const PlaceholderTab(
                  title: 'Materi',
                  message: 'Ringkasan materi N3 akan tersedia di sini.',
                ),
              3 => const PlaceholderTab(
                  title: 'Progress',
                  message: 'Statistik belajar lengkap akan tersedia di sini.',
                ),
              4 => const PlaceholderTab(
                  title: 'Profil',
                  message: 'Pengaturan akun dan profil belajar akan tersedia di sini.',
                ),
              _ => _HomeBody(
                  now: now,
                  hasUnseenTips: hasUnseenTips,
                  sort: _sort,
                  onSortChanged: (sort) => setState(() => _sort = sort),
                  onToggleTheme: session.toggleTheme,
                  onOpenTips: () => _openTips(context, now),
                  onOpenSection: (section) => _openSection(context, section),
                  sortedSections: _sortedSections,
                  answeredCount: _answeredCount,
                  session: session,
                ),
            },
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex == 2 ? 0 : _selectedIndex,
            onDestinationSelected: _onNavTap,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded, color: AppTheme.coral),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book_rounded),
                label: 'Materi',
              ),
              NavigationDestination(
                icon: Icon(Icons.edit_outlined),
                selectedIcon: Icon(Icons.edit_rounded),
                label: 'Latihan',
              ),
              NavigationDestination(
                icon: Icon(Icons.insights_outlined),
                selectedIcon: Icon(Icons.insights_rounded),
                label: 'Progress',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Profil',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({
    required this.darkMode,
    required this.onToggleTheme,
  });

  final bool darkMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppTheme.coral,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.asset(
                      'assets/app_logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            '森',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nihongo no Mori', style: Theme.of(context).textTheme.titleMedium),
                        Text('Latihan harian N3', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Mode gelap'),
              subtitle: Text(darkMode ? 'Aktif' : 'Nonaktif'),
              secondary: Icon(darkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
              value: darkMode,
              onChanged: (_) {
                HapticFeedback.selectionClick();
                onToggleTheme();
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Aplikasi latihan JLPT N3 dengan Kapizamurai — mascot hutan yang menemani belajarmu.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    required this.now,
    required this.hasUnseenTips,
    required this.sort,
    required this.onSortChanged,
    required this.onToggleTheme,
    required this.onOpenTips,
    required this.onOpenSection,
    required this.sortedSections,
    required this.answeredCount,
    required this.session,
  });

  final DateTime now;
  final bool hasUnseenTips;
  final _SectionSort sort;
  final ValueChanged<_SectionSort> onSortChanged;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenTips;
  final void Function(SyllabusSection section) onOpenSection;
  final List<SyllabusSection> Function(List<SyllabusSection> sections) sortedSections;
  final int Function(SyllabusSection section) answeredCount;
  final PracticeSession session;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        _TopBar(
          darkMode: session.stats.darkMode,
          hasUnseenTips: hasUnseenTips,
          onToggleTheme: onToggleTheme,
          onOpenTips: onOpenTips,
        ),
        const SizedBox(height: 16),
        _StatsCard(
          streak: session.stats.displayStreak(now),
          xp: session.stats.xp,
          level: session.stats.level,
        ),
        const SizedBox(height: 20),
        for (final chapter in chapters) ...[
          _ForestHero(
            chapter: chapter,
            message: dailyMessageFor(now),
            levelProgress: session.stats.levelProgress,
            level: session.stats.level,
            xpIntoLevel: session.stats.xpIntoLevel,
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih sub-bab', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      'Progres masing-masing terpisah.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<_SectionSort>(
                tooltip: 'Urutkan',
                onSelected: onSortChanged,
                itemBuilder: (context) => const [
                  PopupMenuItem(value: _SectionSort.syllabus, child: Text('Urutan silabus')),
                  PopupMenuItem(value: _SectionSort.title, child: Text('Judul A–Z')),
                  PopupMenuItem(value: _SectionSort.progress, child: Text('Progres terendah')),
                ],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Urutkan',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Icon(Icons.expand_more_rounded, size: 20),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final section in sortedSections(chapter.sections)) ...[
            _SectionCard(
              section: section,
              answered: answeredCount(section),
              onTap: () => onOpenSection(section),
            ),
            const SizedBox(height: 14),
          ],
        ],
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.darkMode,
    required this.hasUnseenTips,
    required this.onToggleTheme,
    required this.onOpenTips,
  });

  final bool darkMode;
  final bool hasUnseenTips;
  final VoidCallback onToggleTheme;
  final VoidCallback onOpenTips;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Menu',
          onPressed: () {
            HapticFeedback.selectionClick();
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu_rounded),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppTheme.coral,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Color(0x33E36D58), blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Image.asset(
                  'assets/app_logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        '森',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nihongo no Mori',
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Latihan harian N3',
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: darkMode ? 'Mode terang' : 'Mode gelap',
          onPressed: () {
            HapticFeedback.selectionClick();
            onToggleTheme();
          },
          icon: Icon(darkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              tooltip: 'Pesan hari ini',
              onPressed: () {
                HapticFeedback.selectionClick();
                onOpenTips();
              },
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            if (hasUnseenTips)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1.5),
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, height: 1),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.streak,
    required this.xp,
    required this.level,
  });

  final int streak;
  final int xp;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        boxShadow: const [BoxShadow(color: Color(0x0C172033), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          Expanded(child: _StatColumn(icon: Icons.local_fire_department_rounded, color: AppTheme.coral, label: 'Streak', value: '$streak hari')),
          Expanded(child: _StatColumn(icon: Icons.star_rounded, color: AppTheme.gold, label: 'XP', value: '$xp')),
          Expanded(child: _StatColumn(icon: Icons.shield_rounded, color: AppTheme.blue, label: 'Level', value: '$level')),
          const Expanded(child: _StatColumn(icon: Icons.gps_fixed_rounded, color: AppTheme.coral, label: 'Target', value: 'N3')),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 11, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ForestHero extends StatelessWidget {
  const _ForestHero({
    required this.chapter,
    required this.message,
    required this.levelProgress,
    required this.level,
    required this.xpIntoLevel,
  });

  final SyllabusChapter chapter;
  final String message;
  final double levelProgress;
  final int level;
  final int xpIntoLevel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E293B), Color(0xFF243248), Color(0xFF1E293B)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              right: -8,
              top: -28,
              child: Text(
                '森',
                style: TextStyle(fontSize: 140, height: 1, color: Color(0x18FFFFFF), fontWeight: FontWeight.w800),
              ),
            ),
            const Positioned(
              right: 16,
              bottom: 8,
              child: Text(
                '語',
                style: TextStyle(fontSize: 52, color: Color(0x12FFFFFF), fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0x33FFFFFF),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            'BAB ${chapter.roman} · 文字・語彙',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          chapter.title,
                          style: const TextStyle(color: Colors.white, fontSize: 24, height: 1.15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          message,
                          style: const TextStyle(color: Color(0xFFD7E0EE), fontSize: 13, height: 1.35, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Level $level',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value: levelProgress,
                            minHeight: 10,
                            color: AppTheme.coral,
                            backgroundColor: const Color(0x33FFFFFF),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$xpIntoLevel / ${LearnerStats.xpPerLevel} XP ke level berikutnya',
                          style: const TextStyle(color: Color(0xFFB7C3D6), fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 128,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 2))],
                          ),
                          child: const Text(
                            'がんばれ!',
                            style: TextStyle(color: Color(0xFF1E293B), fontSize: 11, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const ClipRect(
                          child: MoriMascot(pose: MascotPose.hero, size: 128),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.section,
    required this.answered,
    required this.onTap,
  });

  final SyllabusSection section;
  final int answered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final look = SectionStyle.of(section.number);
    final total = section.questions.length;
    final progress = total == 0 ? 0.0 : answered / total;
    final percent = (progress * 100).round();
    final status = total == 0
        ? 'Kosong'
        : answered == 0
            ? 'Mulai'
            : answered >= total
                ? 'Ulangi'
                : 'Lanjutkan';
    final outline = Theme.of(context).colorScheme.outline;
    final wash = look.washFor(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: outline),
            boxShadow: const [BoxShadow(color: Color(0x14172033), blurRadius: 16, offset: Offset(0, 8))],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              children: [
                Row(
                  children: [
                    SectionIcon(style: look, size: 52),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$answered / $total soal',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: onTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: look.accent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(88, 38),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                      ),
                      child: Text(status),
                    ),
                  ],
                ),
                if (total > 0) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '$percent%',
                        style: TextStyle(color: look.accent, fontWeight: FontWeight.w800, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      color: look.accent,
                      backgroundColor: wash,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
