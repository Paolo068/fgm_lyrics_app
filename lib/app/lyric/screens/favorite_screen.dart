import 'package:fgm_lyrics_app/app/locale/locale_controller.dart';
import 'package:fgm_lyrics_app/app/lyric/lyric_controller.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/lyric_detail_screen.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_tile.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/shared/app_default_spacing.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends ConsumerWidget {
  final bool languageIsEnglish;
  const FavoriteScreen({super.key, required this.languageIsEnglish});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageIsEnglish = ref.watch(deviceLocaleProvider) == 'en';
    final lyrics =
        languageIsEnglish
            ? ref.watch(englishLyricProvider).value
            : ref.watch(frenchLyricProvider).value;

    return Theme(
      data: context.theme.copyWith(
        textTheme: context.textTheme.apply(
          fontFamily: GoogleFonts.barlow().fontFamily,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                ref
                    .read(deviceLocaleProvider.notifier)
                    .setLocale(languageIsEnglish ? 'fr' : 'en');
              },
              child: Text(languageIsEnglish ? 'FR' : 'EN'),
            ),

            SearchAnchor(
              builder: (context, controller) {
                return IconButton(
                  onPressed: () {
                    controller.clear();
                    controller.openView();
                  },
                  icon: const Icon(Icons.search_outlined),
                );
              },
              dividerColor: Colors.grey.shade400,
              suggestionsBuilder: (context, controller) {
                final filteredLyrics = filterLyrics(lyrics, controller);

                return filteredLyrics.map((lyric) {
                  return ListTile(
                    title: Text(lyric.songTitle),
                    onTap: () {
                      controller.closeView(
                        lyric.songTitle,
                      ); // Close search on selection
                      context.push(
                        LyricDetailScreen(
                          lyric: lyric,
                          languageIsEnglish: languageIsEnglish,
                        ),
                      );
                    },
                  );
                }).toList();
              },
            ),
          ],
          title: Text(languageIsEnglish ? 'Favorite' : 'Favoris'),
        ),
        body: AppDefaultSpacing(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final lyric = lyrics?[index];
              return LyricTile(
                lyric: lyric,
                languageIsEnglish: languageIsEnglish,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.black.withAlpha(20));
            },
            itemCount: lyrics?.length ?? 0,
          ),
        ),
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
