import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

final MethodChannel methodChannel = MethodChannel('media_metadata_retriever');

class Metadata {
  final String title;
  final String album;
  final String artists;
  final String year;
  final String trackNumber;
  final String albumLength;
  final String albumArtist;
  final String genre;
  final String author;
  final String writer;
  final String discNumber;
  final String filePath;
  final String mimeType;

  Metadata(
      {this.title,
      this.album,
      this.artists,
      this.year,
      this.trackNumber,
      this.albumLength,
      this.albumArtist,
      this.genre,
      this.author,
      this.writer,
      this.discNumber,
      this.filePath,
      this.mimeType});
}

class MediaMetadataRetriever {
  File _mediaFile;
  Uint8List albumArt;
  int duration;
  int bitrate;

  Future<void> setFile(File mediaFile) async {
    this._mediaFile = mediaFile;
    if (await mediaFile.exists()) {
      await methodChannel.invokeMethod('setFilePath', {
        'filePath': mediaFile.path,
      });
      this.albumArt = await methodChannel.invokeMethod('getAlbumArt');
      this.duration = await methodChannel.invokeMethod('getDuration');
      this.bitrate = await methodChannel.invokeMethod('getBitrate');
    } else {
      throw 'ERROR: Media file does not exist.';
    }
  }

  Future<Metadata> get metadata async {
    var metadata = await methodChannel.invokeMethod('getMetadata');
    String trackNumber = metadata['trackNumber'] ?? '1';
    return new Metadata(
      title: metadata['title'],
      album: metadata['album'],
      artists: metadata['artists'],
      year: metadata['year'],
      trackNumber: trackNumber.split('/').first,
      albumLength: trackNumber.split('/').last,
      albumArtist: metadata['albumArtist'],
      genre: metadata['genre'],
      author: metadata['author'],
      writer: metadata['writer'],
      discNumber: metadata['discNumber'],
      filePath: this._mediaFile.path,
      mimeType: metadata['mimeType'],
    );
  }
}
