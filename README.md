# [media_metadata_retriever](https://github.com/alexmercerind/media_metadata_retriever)

A simple Flutter plugin for reading 🔖 metadata of 🎞 media files.

## 💾 Install

Mention in pubspec.yaml
```yaml
dependencies:
  ...
  media_metadata_retriever: ^0.0.1+1
```
Fetch the plugin from pub.dev
```
flutter pub get
```

## 📐 Usage

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

## 🖼 Example

You may checkout example app for this plugin [here](https://github.com/alexmercerind/media_metadata_retriever/tree/master/example/lib/main.dart);

![https://github.com/alexmercerind/media_metadata_retriever/tree/master/screenshots/sreenshot0.png]
![https://github.com/alexmercerind/media_metadata_retriever/tree/master/screenshots/sreenshot1.png]


## ✔ Progress

|Platform|Status     |
|--------|-----------|
|Android |Working    |
|Linux   |Coming Soon|
|Windows |Now Working|


## 🧷 How?

Well, [MediaMetadataRetriever](https://developer.android.com/reference/android/media/MediaMetadataRetriever) on Android does the job.
