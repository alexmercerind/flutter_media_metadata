# [flutter_media_metadata](https://github.com/alexmercerind/flutter_media_metadata)

Flutter plugin for reading :bookmark: metadata of :musical_note: media files.

## Installing

```yaml
dependencies:
  flutter_media_metadata: ^0.0.3
```

## Using

```dart
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

var retriever = new MetadataRetriever();
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

await retriever.setUri(new Uri.https('www.example.com', '/audio.MP3', {}));

Map<String, dynamic> = await metadata.toMap();

```

For using this plugin in Linux Desktop app, you must install [MediaInfoLib](https://github.com/MediaArea/MediaInfoLib).

On debian based distros, run

```bash
sudo apt install libmediainfo-dev
```

## :blue_heart: Supporting

<a href="https://www.buymeacoffee.com/alexmercerind"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=alexmercerind&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff"></a>

## :iphone: Example

You may checkout example app for this plugin [here](https://github.com/alexmercerind/flutter_media_metadata/tree/master/example/lib/main.dart).

#### Android

<img src="https://github.com/alexmercerind/flutter_media_metadata/blob/assets/android.png?raw=true" height="450"></img>

#### Linux

<img src="https://github.com/alexmercerind/flutter_media_metadata/blob/assets/linux.png?raw=true" height="500"></img>


## :heavy_check_mark: Progress

|Platform|Status     |
|--------|-----------|
|Android |Working    |
|Linux   |Working    |
|Windows |Coming Soon|

