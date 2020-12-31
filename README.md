# [media_metadata_retriever](https://github.com/alexmercerind/media_metadata_retriever)

A simple Flutter plugin for reading :bookmark: metadata of :musical_note: media files.

## :triangular_ruler: Usage

```dart
import 'package:media_metadata_retriever/media_metadata_retriever.dart';

Future<void> getMetadata() async {
    // Instantiate the MediaMetadataRetriever class
    final metadataRetriever = new MediaMetadataRetriever();
    // Set media file path
    await metadataRetriever.setFile(File('/storage/emulated/0/Music/music.aac'));

    // Retrieve metadata
    Metadata metadata = await metadataRetriever.metadata;

    // Use the way you want
    print(metadata.title);
    print(metadata.album);
    print(metadata.artists);
    print(metadata.year);
    print(metadata.trackNumber);
    print(metadata.albumLength);
    print(metadata.albumArtist);
    print(metadata.genre);
    print(metadata.author);
    print(metadata.writer);
    print(metadata.discNumber);
    print(metadata.filePath);
    print(metadata.mimeType);
    print(metadataRetriever.duration);
    print(metadataRetriever.bitrate);
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
