import 'package:flutter/material.dart';

import 'models/practice_session.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NihongoNoMoriApp());
}

class NihongoNoMoriApp extends StatefulWidget {
  const NihongoNoMoriApp({super.key});

  @override
  State<NihongoNoMoriApp> createState() => _NihongoNoMoriAppState();
}

class _NihongoNoMoriAppState extends State<NihongoNoMoriApp> {
  final _session = PracticeSession();

  @override
  void dispose() {
    _session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nihongo no Mori',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: HomeScreen(session: _session),
    );
  }
}
