import 'package:fgm_lyrics_app/app/locale/locale_provider.dart';
import 'package:fgm_lyrics_app/app/lyric/lyric_controller.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_tile.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/widgets/app_default_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageIsEnglish =
        ref.watch(deviceLocaleProvider) == LanguageEnum.en.name;
    final asyncLyrics = languageIsEnglish
        ? ref.watch(englishHymnProvider)
        : ref.watch(frenchHymnProvider);

    return AppDefaultSpacing(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final lyric = asyncLyrics.requireValue[index];
          asyncLyrics.isLoading
              ? const Center(child: CircularProgressIndicator())
              : LyricTile(lyric: lyric);
          return null;
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.black.withAlpha(20));
        },
        itemCount: asyncLyrics.requireValue.length,
      ),
    );
  }

  List<Lyric> filterLyrics(List<Lyric>? lyrics, SearchController controller) {
    return lyrics
            ?.where(
              (lyric) => lyric.songTitle.toLowerCase().contains(
                controller.text.toLowerCase(),
              ),
            )
            .toList() ??
        [];
  }
}
