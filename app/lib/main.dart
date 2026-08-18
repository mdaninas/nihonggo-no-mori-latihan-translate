import 'package:flutter/material.dart';

import 'models/practice_session.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final session = await PracticeSession.load();
  runApp(NihongoNoMoriApp(session: session));
}

class NihongoNoMoriApp extends StatelessWidget {
  const NihongoNoMoriApp({required this.session, super.key});

  final PracticeSession session;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: session,
      builder: (context, _) {
        return MaterialApp(
          title: 'Nihongo no Mori',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: session.themeMode,
          home: HomeScreen(session: session),
        );
      },
    );
  }
}
