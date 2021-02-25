# [flutter_media_metadata](https://github.com/alexmercerind/flutter_media_metadata)

Flutter plugin for reading :bookmark: metadata of :musical_note: media files.

## :floppy_disk: Install

```yaml
dependencies:
  flutter_media_metadata: ^0.0.3
```

## :triangular_ruler: Usage

```dart
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

Future<Map<String, dynamic>> getFromFile() async {
    final retriever = new MetadataRetriever();
    await retriever.setFile(new File('/storage/emulated/0/Music/music.aac'));
    Metadata metadata = await retriever.metadata;
    metadata.trackName;
    metadata.trackArtistNames;
    metadata.albumName;
    metadata.albumArtistName;
    metadata.trackNumber;
    metadata.albumLength;
    metadata.year;
    metadata.genre;
    metadata.authorName;
    metadata.writerName;
    metadata.discNumber;
    metadata.mimeType;
    metadata.trackDuration;
    metadata.bitrate;
    retriever.albumArt;
    return metadata.toMap();
}

Future<Map<String, dynamic>> getFromUri() async {
  final retriever = new MetadataRetriever();
  await retriever.setUri(new Uri.https('www.example.com', '/audio.MP3', {}));
  return (await retriever.metadata).toMap();
}
```

For using this plugin in Linux Desktop App, you must install libmediainfo-dev.

On debian based distros, run

```bash
sudo apt install libmediainfo-dev
```

## :iphone: Example

You may checkout example app for this plugin [here](https://github.com/alexmercerind/flutter_media_metadata/tree/master/example/lib/main.dart).


|Android|Linux|
|-|-|
|![](https://github.com/alexmercerind/flutter_media_metadata/blob/assets/android.png?raw=true)|![](https://github.com/alexmercerind/flutter_media_metadata/blob/assets/linux.png?raw=true)|


## :heavy_check_mark: Progress

|Platform|Status     |
|--------|-----------|
|Android |Working    |
|Linux   |Working    |
|Windows |Coming Soon|


## :blue_heart: Like Plugin?

Consider starring the repository to support development.
