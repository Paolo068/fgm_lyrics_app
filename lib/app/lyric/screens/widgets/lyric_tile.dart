import 'package:fgm_lyrics_app/app/lyric/screens/lyric_detail_screen.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class LyricTile extends StatelessWidget {
  const LyricTile({
    super.key,
    required this.lyric,
    required this.languageIsEnglish,
  });
  final Lyric? lyric;
  final bool languageIsEnglish;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(
          LyricDetailScreen(
            lyric: lyric!,
            languageIsEnglish: languageIsEnglish,
          ),
        );
      },
      minVerticalPadding: 0,
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: Text(
        "${lyric?.id}",
        style: context.textTheme.bodyMedium,
      ),
      title: Text(
        lyric?.songTitle ?? '',
        style: context.textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
