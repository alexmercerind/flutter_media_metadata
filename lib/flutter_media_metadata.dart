import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';

var _kChannel = const MethodChannel('flutter_media_metadata');

class MetadataRetriever {
  static Future<Metadata> fromFile(
    File file, {
    bool createNewInstance: false,
  }) async {
    var metadata = await _kChannel.invokeMethod(
      'MetadataRetriever',
      {
        'filePath': file.path,
        'createNewInstance': createNewInstance,
      },
    );
    metadata['filePath'] = file.path;
    return Metadata.fromJson(metadata);
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
  final String filePath;

  const Metadata({
    this.trackName,
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
    this.albumArt,
    required this.filePath,
  });

  factory Metadata.fromJson(dynamic map) => Metadata(
        trackName: map['metadata']['trackName'],
        trackArtistNames: map['metadata']['trackArtistNames'] != null
            ? map['metadata']['trackArtistNames'].split('/')
            : null,
        albumName: map['metadata']['albumName'],
        albumArtistName: map['metadata']['albumArtistName'],
        trackNumber: _parse(map['metadata']['trackNumber']),
        albumLength: _parse(map['metadata']['albumLength']),
        year: _parse(map['metadata']['year']),
        genre: map['genre'],
        authorName: map['metadata']['authorName'],
        writerName: map['metadata']['writerName'],
        discNumber: _parse(map['metadata']['discNumber']),
        mimeType: map['metadata']['mimeType'],
        trackDuration: _parse(map['metadata']['trackDuration']),
        bitrate: _parse(map['metadata']['bitrate']),
        albumArt: map['albumArt'],
        filePath: map['filePath'],
      );

  Map<String, dynamic> toJson() => {
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
        'filePath': filePath,
      };

  @override
  String toString() => JsonEncoder.withIndent('    ').convert(toJson());
}

int? _parse(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is int) {
    return value;
  } else if (value is String) {
    try {
      try {
        return int.parse(value);
      } catch (_) {
        return int.parse(value.split('/').first);
      }
    } catch (_) {}
  }
  return null;
}
