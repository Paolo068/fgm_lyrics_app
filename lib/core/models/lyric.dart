import 'dart:convert';

import 'package:equatable/equatable.dart';

class Lyric extends Equatable {
  final String songTitle;
  final int songId;
  final dynamic id;
  final String chorus;
  final String key;
  final String author;
  final List<String> enLyrics;
  const Lyric({
    required this.songTitle,
    required this.songId,
    required this.id,
    required this.chorus,
    required this.key,
    required this.author,
    required this.enLyrics,
  });

  Lyric copyWith({
    String? songTitle,
    int? songId,
    dynamic id,
    String? chorus,
    String? key,
    String? author,
    List<String>? enLyrics,
  }) {
    return Lyric(
      songTitle: songTitle ?? this.songTitle,
      songId: songId ?? this.songId,
      id: id ?? this.id,
      chorus: chorus ?? this.chorus,
      key: key ?? this.key,
      author: author ?? this.author,
      enLyrics: enLyrics ?? this.enLyrics,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'songTitle': songTitle,
      'songId': songId,
      'id': id,
      'chorus': chorus,
      'key': key,
      'author': author,
      'enLyrics': enLyrics,
    };
  }

  factory Lyric.fromMap(Map<String, dynamic> map) {
    return Lyric(
      songTitle: map['songTitle'] ?? '',
      songId: map['songId']?.toInt() ?? 0,
      id: map['id'],
      chorus: map['chorus'] ?? '',
      key: map['key'] ?? '',
      author: map['author'] ?? '',
      enLyrics: List<String>.from(map['enLyrics'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lyric.fromJson(String source) => Lyric.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lyric(songTitle: $songTitle, songId: $songId, id: $id, chorus: $chorus, key: $key, author: $author, enLyrics: $enLyrics)';
  }

  @override
  List<Object> get props {
    return [songTitle, songId, id, chorus, key, author, enLyrics];
  }
}
