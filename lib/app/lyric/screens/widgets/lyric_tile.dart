import 'package:fgm_lyrics_app/app/lyric/screens/lyric_detail_screen.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class LyricTile extends StatelessWidget {
  const LyricTile({
    super.key,
    required this.lyric,
    required this.isEnglish,
    this.contentPadding = EdgeInsets.zero,
  });
  final EdgeInsetsGeometry? contentPadding;
  final Lyric? lyric;
  final bool isEnglish;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(LyricDetailScreen(lyric: lyric!, isEnglish: isEnglish));
      },
      contentPadding: contentPadding,
      visualDensity: VisualDensity.compact,
      leading: Text(
        "${lyric?.id}",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      title: Text(
        lyric?.songTitle ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
