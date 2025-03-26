import 'package:fgm_lyrics_app/app/locale/locale_notifer.dart';
import 'package:fgm_lyrics_app/app/lyric/notifier/lyric_notifier.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/lyric_list_screen.dart'
    show LyricListScreen;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show
        ConsumerWidget,
        ProviderContainer,
        UncontrolledProviderScope,
        WidgetRef;
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(deviceLocaleProvider);
  container.read(frenchLyricProvider);
  container.read(englishLyricProvider);
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'FGM Hymns',
      theme: ThemeData(fontFamily: GoogleFonts.ebGaramond().fontFamily),
      home: const LyricListScreen(),
    );
  }
}
