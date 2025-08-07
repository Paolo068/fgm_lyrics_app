import 'package:fgm_lyrics_app/app/locale/locale_controller.dart';
import 'package:fgm_lyrics_app/app/lyric/lyric_controller.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/lyric_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitializer(
      child: MaterialApp(
        title: 'FGM Hymns',
        theme: ThemeData(fontFamily: GoogleFonts.ebGaramond().fontFamily),
        home: const LyricListScreen(),
      ),
    );
  }
}

class _EagerInitializer extends ConsumerWidget {
  final Widget child;
  const _EagerInitializer({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(deviceLocaleProvider);
    ref.watch(frenchLyricProvider);
    ref.watch(englishLyricProvider);
    return child;
  }
}
