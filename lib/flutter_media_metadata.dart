import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';

final MethodChannel _methodChannel = MethodChannel('flutter_media_metadata');

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

  /// ## Access Metadata as a Map
  ///
  ///  You may use [toMap] method to get metadata in form of a `Map<String, dynamic>`.
  ///
  ///     Map<String, dynamic> metadataMap = metadata.toMap();
  ///
  Map<String, dynamic> toMap() {
    return {
      'trackName': this.trackName,
      'trackArtistNames': this.trackArtistNames,
      'albumName': this.albumName,
      'albumArtistName': this.albumArtistName,
      'trackNumber': this.trackNumber,
      'albumLength': this.albumLength,
      'year': this.year,
      'genre': this.genre,
      'authorName': this.authorName,
      'writerName': this.writerName,
      'discNumber': this.discNumber,
      'mimeType': this.mimeType,
      'trackDuration': this.trackDuration,
      'bitrate': this.bitrate,
    };
  }

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
  });
}

class MetadataRetriever {
  Uint8List? albumArt;

  /// ## Set Media File Path
  ///
  ///  Pass File as the parameter of [setFile] method to access its metadata.
  ///
  ///     final metadataRetriever = new MediaMetadataRetriever();
  ///     await metadataRetriever.setFile(new File('/storage/emulated/0/Music/music.aac'));
  ///
  Future<void> setFile(File mediaFile) async {
    if (await mediaFile.exists()) {
      await _methodChannel.invokeMethod('setFilePath', {
        'filePath': mediaFile.path,
      });
      try {
        if (Platform.isLinux) {
          String albumArtBase64 =
              await (_methodChannel.invokeMethod('getAlbumArt') as FutureOr<String>);
          this.albumArt = base64Decode(albumArtBase64);
        }
        if (Platform.isAndroid) {
          this.albumArt = await _methodChannel.invokeMethod('getAlbumArt');
        }
      } catch (exception) {
        this.albumArt = null;
      }
    } else {
      throw 'Exception: Media file does not exist.';
    }
  }

  /// ## Set Media URL
  ///
  ///  Pass Uri as the parameter of [setUri] method to access its metadata.
  ///
  ///     final metadataRetriever = new MediaMetadataRetriever();
  ///     await metadataRetriever.setFile(new Uri.https('www.example.com', '/audio.MP3', {}));
  ///
  Future<void> setUri(Uri uri, {Map<String, dynamic>? headers}) async {
    if (Platform.isLinux) {
      throw UnimplementedError('Exception: Method not implemented on Linux.');
    }
    try {
      await _methodChannel.invokeMethod('setUri', {
        'uri': uri.toString(),
        'headers': headers ?? <String, dynamic>{},
      });
      try {
        this.albumArt = await _methodChannel.invokeMethod('getAlbumArt');
      } catch (exception) {
        this.albumArt = null;
      }
    } catch (exception) {
      throw 'Exception: Could not retrieve metadata.';
    }
  }

  /// ## Access Metadata
  ///
  ///  Access metadata of the media file loaded using [setFile] method.
  ///
  ///     Metadata metadata = await metadataRetriever.metadata;
  ///
  Future<Metadata> get metadata async {
    var metadata = await _methodChannel.invokeMethod('getMetadata');
    if (Platform.isLinux) {
      metadata.forEach((dynamic key, dynamic value) {
        if (value == '') metadata[key] = null;
      });
      if (metadata['trackArtistNames'] != null)
        metadata['trackArtistNames'] = (metadata['trackArtistNames'] as String).split('/');
      if (metadata['trackNumber'] != null) {
        String trackNumber = metadata['trackNumber'];
        metadata['trackNumber'] = int.tryParse(trackNumber.split('/').first);
        metadata['albumLength'] = int.tryParse(trackNumber.split('/').last);
      }
      metadata['year'] = int.tryParse(metadata['year'] ?? "");
      metadata['trackDuration'] = int.tryParse(metadata['trackDuration'] ?? "");
      metadata['bitrate'] = int.tryParse(metadata['bitrate'] ?? "");
    }
    return new Metadata(
      trackName: metadata['trackName'],
      trackArtistNames: metadata['trackArtistNames'],
      albumName: metadata['albumName'],
      albumArtistName: metadata['albumArtistName'],
      trackNumber: metadata['trackNumber'],
      albumLength: metadata['albumLength'],
      year: metadata['year'],
      genre: metadata['genre'],
      authorName: metadata['authorName'],
      writerName: metadata['writerName'],
      discNumber: metadata['discNumber'],
      mimeType: metadata['mimeType'],
      trackDuration: metadata['trackDuration'],
      bitrate: metadata['bitrate'],
    );
  }
}
