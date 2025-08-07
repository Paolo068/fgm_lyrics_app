import 'package:audioplayers/audioplayers.dart' show AudioPlayer;
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_chorus.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_first_verse.dart';
import 'package:fgm_lyrics_app/app/lyric/screens/widgets/lyric_verses.dart';
import 'package:fgm_lyrics_app/core/models/lyric.dart';
import 'package:fgm_lyrics_app/core/shared/app_default_spacing.dart';
import 'package:fgm_lyrics_app/core/utils/context_extension.dart';
import 'package:fgm_lyrics_app/core/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class LyricDetailScreen extends StatefulWidget {
  final bool languageIsEnglish;
  final Lyric lyric;
  const LyricDetailScreen({
    super.key,
    required this.languageIsEnglish,
    required this.lyric,
  });

  @override
  State<LyricDetailScreen> createState() => _LyricDetailScreenState();
}

class _LyricDetailScreenState extends State<LyricDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _audioPlayer = AudioPlayer();
  final _sharePlus = SharePlus.instance;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Text(
          '${widget.lyric.id}.  ${widget.lyric.songTitle.capitalize}',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed:
                () async => await _sharePlus.share(
                  ShareParams(
                    text: hymnText,
                    subject: '${widget.lyric.songTitle.capitalize} - FGM Hymns',
                  ),
                ),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: AppDefaultSpacing(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: DefaultTextStyle(
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.lyric.author.isNotEmpty
                          ? Text(
                            '${widget.languageIsEnglish ? 'Author: ' : 'Auteur: '} ${widget.lyric.author}',
                          )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 2),
                      widget.lyric.key.isNotEmpty
                          ? Text(
                            '${widget.languageIsEnglish ? 'Key: ' : 'Clef: '} ${widget.lyric.key}',
                          )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              LyricFirstVerse(enLyrics: widget.lyric.enLyrics),

              widget.lyric.chorus.isNotEmpty
                  ? const SizedBox(height: 20)
                  : const SizedBox.shrink(),

              widget.lyric.chorus.isNotEmpty
                  ? LyricChorus(chorus: widget.lyric.chorus)
                  : const SizedBox.shrink(),

              const SizedBox(height: 20),
              LyricVerses(enLyrics: widget.lyric.enLyrics),
            ],
          ),
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

  String get hymnText {
    return "*${widget.lyric.songId}.  ${widget.lyric.songTitle}*\n\n"
        "${widget.lyric.enLyrics.first}\n\n\n"
        "${widget.lyric.chorus.isNotEmpty
            ? widget.languageIsEnglish
                ? "*Chorus :*\n"
                : "*Refrain :*\n"
            : ''}"
        "${widget.lyric.chorus.isNotEmpty ? "${widget.lyric.chorus}\n\n\n" : ''}"
        "${widget.lyric.enLyrics.length > 1 ? widget.lyric.enLyrics.sublist(1, widget.lyric.enLyrics.length - 1).map((lyric) => "${lyric.trim()}\n\n").join(' ').toString() : ''}";
  }
}
