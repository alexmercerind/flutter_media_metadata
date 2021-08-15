import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';

var kChannel = const MethodChannel('flutter_media_metadata');

class MetadataRetriever {
  static Future<Metadata> fromFile(File file) async {
    return Metadata.fromMap(await kChannel
        .invokeMethod('MetadataRetriever', {'filePath': file.path}));
  }
}

class Metadata {
  final String? trackName;
  final List<String>? trackArtistNames;
  final String? albumName;
  final String? albumArtistName;
  final int? trackNumber;
  final int? albumLength;
  final int? year;
  final String? genre;
  final String? authorName;
  final String? writerName;
  final int? discNumber;
  final String? mimeType;
  final int? trackDuration;
  final int? bitrate;
  final Uint8List? albumArt;

  const Metadata(
      {this.trackName,
      this.trackArtistNames,
      this.albumName,
      this.albumArtistName,
      this.trackNumber,
      this.albumLength,
      this.year,
      this.genre,
      this.authorName,
      this.writerName,
      this.discNumber,
      this.mimeType,
      this.trackDuration,
      this.bitrate,
      this.albumArt});

  static fromMap(dynamic map) => Metadata(
      trackName: map['metadata']['trackName'],
      trackArtistNames: map['metadata']['trackArtistNames'] != null
          ? map['metadata']['trackArtistNames'].split('/')
          : null,
      albumName: map['metadata']['albumName'],
      albumArtistName: map['metadata']['albumArtistName'],
      trackNumber: _parseInt(map['metadata']['trackNumber']),
      albumLength: _parseInt(map['metadata']['albumLength']),
      year: _parseInt(map['metadata']['year']),
      genre: map['genre'],
      authorName: map['metadata']['authorName'],
      writerName: map['metadata']['writerName'],
      discNumber: _parseInt(map['metadata']['discNumber']),
      mimeType: map['metadata']['mimeType'],
      trackDuration: _parseInt(map['metadata']['trackDuration']),
      bitrate: _parseInt(map['metadata']['bitrate']),
      albumArt: map['albumArt']);

  Map<String, dynamic> toMap() => {
        'trackName': trackName,
        'trackArtistNames': trackArtistNames,
        'albumName': albumName,
        'albumArtistName': albumArtistName,
        'trackNumber': trackNumber,
        'albumLength': albumLength,
        'year': year,
        'genre': genre,
        'authorName': authorName,
        'writerName': writerName,
        'discNumber': discNumber,
        'mimeType': mimeType,
        'trackDuration': trackDuration,
        'bitrate': bitrate,
      };

  @override
  String toString() => JsonEncoder.withIndent('    ').convert(toMap());
}

int? _parseInt(dynamic value) {
  try {
    return int.tryParse(value);
  } catch (exception) {}
  return null;
}
