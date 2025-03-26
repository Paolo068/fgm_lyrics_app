import 'package:audioplayers/audioplayers.dart' show AudioPlayer;
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_chorus.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_first_verse.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_title.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_verses.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/shared/app_default_spacing.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart' show Share;

class LyricDetailScreen extends StatefulWidget {
  final bool isEnglish;
  final Lyric lyric;
  const LyricDetailScreen({
    super.key,
    required this.isEnglish,
    required this.lyric,
  });

  @override
  State<LyricDetailScreen> createState() => _LyricDetailScreenState();
}

class _LyricDetailScreenState extends State<LyricDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    String hymnText =
        "*${widget.lyric.songId}.  ${widget.lyric.songTitle}*\n\n"
        "${widget.lyric.enLyrics.first}\n\n\n"
        "${widget.lyric.chorus.isNotEmpty
            ? widget.isEnglish
                ? "*Chorus :*\n"
                : "*Refrain :*\n"
            : ''}"
        "${widget.lyric.chorus.isNotEmpty ? "${widget.lyric.chorus}\n\n\n" : ''}"
        "${widget.lyric.enLyrics.length > 1 ? widget.lyric.enLyrics.sublist(1, widget.lyric.enLyrics.length - 1).map((lyric) => "${lyric.trim()}\n\n").join(' ').toString() : ''}";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: LyricTitle(lyric: widget.lyric, isEnglish: widget.isEnglish),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed: () async => await Share.share(hymnText),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: AppDefaultSpacing(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            LyricFirstVerse(enLyrics: widget.lyric.enLyrics),
            widget.lyric.chorus.isNotEmpty
                ? LyricChorus(chorus: widget.lyric.chorus)
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
            LyricVerses(enLyrics: widget.lyric.enLyrics),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_animationController.isCompleted) {
            _animationController.forward();
            // _audioPlayer.play(widget.lyric.audioUrl);
          } else {
            _animationController.reverse();
            // _audioPlayer.stop();
          }
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animationController,
        ),
      ),
    );
  }
}
