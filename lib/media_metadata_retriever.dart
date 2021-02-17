import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

final MethodChannel _methodChannel = MethodChannel('media_metadata_retriever');

class Metadata {
  final String trackName;
  final List<dynamic> trackArtistNames;
  final String albumName;
  final String albumArtistName;
  final int trackNumber;
  final int albumLength;
  final int year;
  final String genre;
  final String authorName;
  final String writerName;
  final int discNumber;
  final String mimeType;
  final int trackDuration;
  final int bitrate;

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

  Metadata({
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


class MediaMetadataRetriever {
  Uint8List albumArt;

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
      try{
        this.albumArt = await _methodChannel.invokeMethod('getAlbumArt');
        }
      catch(e){
        this.albumArt = null;
      }
    } else {
      throw 'ERROR: Media file does not exist.';
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
