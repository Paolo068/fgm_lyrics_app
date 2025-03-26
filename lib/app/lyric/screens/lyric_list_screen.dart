import 'package:fgm_lyrics_app/app/locale/locale_notifer.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/favorite_screen.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/lyric_detail_screen.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_tile.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/shared/app_default_spacing.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget;
import 'package:google_fonts/google_fonts.dart';

import '../notifier/lyric_notifier.dart';

class LyricListScreen extends ConsumerStatefulWidget {
  const LyricListScreen({super.key});
  @override
  ConsumerState<LyricListScreen> createState() => _LyricListScreenState();
}

class _LyricListScreenState extends ConsumerState<LyricListScreen> {
  @override
  Widget build(BuildContext context) {
    final isEnglish = ref.watch(deviceLocaleProvider) == 'en';
    final lyrics =
        ref.watch(isEnglish ? englishLyricProvider : frenchLyricProvider).value;

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
                setState(() {
                  ref
                      .read(deviceLocaleProvider.notifier)
                      .setLocale(isEnglish ? 'fr' : 'en');
                });
              },
              child: Text(isEnglish ? 'FR' : 'EN'),
            ),
            IconButton(
              onPressed: () {
                context.push(const FavoriteScreen());
              },
              icon: const Icon(Icons.favorite_border_rounded),
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
                        LyricDetailScreen(lyric: lyric, isEnglish: isEnglish),
                      );
                    },
                  );
                }).toList();
              },
            ),
          ],
          title: Text(isEnglish ? 'English' : 'French'),
        ),
        body: AppDefaultSpacing(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final lyric = lyrics?[index];
              return LyricTile(lyric: lyric, isEnglish: isEnglish);
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
