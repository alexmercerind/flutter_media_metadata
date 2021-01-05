# [media_metadata_retriever](https://github.com/alexmercerind/media_metadata_retriever)

A simple Flutter plugin for reading :bookmark: metadata of :musical_note: media files.

## :triangular_ruler: Usage

```dart
import 'package:media_metadata_retriever/media_metadata_retriever.dart';

Future<void> getMetadata() async {
    final metadataRetriever = new MediaMetadataRetriever();
    /* Set File path */
    await metadataRetriever.setFile(new File('/storage/emulated/0/Music/music.aac'));
    /* Access metadata */
    Metadata metadata = await metadataRetriever.metadata;
    print(metadata.trackName);
    print(metadata.trackArtistNames);
    print(metadata.albumName);
    print(metadata.albumArtistName);
    print(metadata.trackNumber);
    print(metadata.albumLength);
    print(metadata.year);
    print(metadata.genre);
    print(metadata.authorName);
    print(metadata.writerName);
    print(metadata.discNumber);
    print(metadata.mimeType);
    print(metadata.trackDuration);
    print(metadata.bitrate);
    /* Alternatively, you may convert to to a Map<String, dynamic> */
    metadata.toMap();
}
```

## :iphone: Example

You may checkout example app for this plugin [here](https://github.com/alexmercerind/media_metadata_retriever/tree/master/example/lib/main.dart).


|Screenshot 1                                                                                                   |Screenshot 2                                                                                       |
|---------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
|![](https://github.com/alexmercerind/media_metadata_retriever/blob/master/screenshots/screenshot0.png?raw=true)|![](https://github.com/alexmercerind/media_metadata_retriever/blob/master/screenshots/screenshot1.png?raw=true)|


## :heavy_check_mark: Progress

|Platform|Status     |
|--------|-----------|
|Android |Working    |
|Linux   |Coming Soon|
|Windows |Now Working|


## :safety_pin: How?

[MediaMetadataRetriever](https://developer.android.com/reference/android/media/MediaMetadataRetriever) on Android does the job. Pretty easy right?
