<h1 align='center'><a href='https://github.com/alexmercerind/flutter_media_metadata'>flutter_media_metadata</a></h1>
<h4 align='center'>A Flutter plugin to read metadata of media files.</h4>
<h5 align='center'>A part of <a href='https://github.com/alexmercerind/harmonoid'>Harmonoid</a> open source project 💜</h5>
<br></br>
<p align='center'><img src='https://github.com/alexmercerind/flutter_media_metadata/blob/assets/linux_active.png?raw=true' height='500'></img></p>

## Install

Add in your `pubspec.yaml`.

```yaml
dependencies:
  ...
  flutter_media_metadata: ^0.1.2
```

Issues are maintained [here](https://github.com/alexmercerind/harmonoid).

## Example

```dart
var metadata = await MetadataRetriever.fromFile(File('C:/Users/Alex/Music/SampleMusic.OGG'))

String? trackName = metadata.trackName;
List<String>? trackArtistNames = metadata.trackArtistNames;
String? albumName = metadata.albumName;
String? albumArtistName = metadata.albumArtistName;
int? trackNumber = metadata.trackNumber;
int? albumLength = metadata.albumLength;
int? year = metadata.year;
String? genre = metadata.genre;
String? authorName = metadata.authorName;
String? writerName = metadata.writerName;
int? discNumber = metadata.discNumber;
String? mimeType = metadata.mimeType;
int? trackDuration = metadata.trackDuration;
int? bitrate = metadata.bitrate;
Uint8List? albumArt = metadata.albumArt;
```

## Platforms

|Platform|Status         |Author/Maintainer                                             |                                                  
|--------|---------------|--------------------------------------------------------------|
|Windows |Working        |[Hitesh Kumar Saini](https://github.com/alexmercerind)        |
|Linux   |Working        |[Hitesh Kumar Saini](https://github.com/alexmercerind)        |
|Android |Working        |[Hitesh Kumar Saini](https://github.com/alexmercerind)        |
|iOS     |Working        |[@DiscombobulatedDrag](https://github.com/DiscombobulatedDrag)|
|MacOS   |Not Working    |[N/A](#)                                                      |

<table>
<tr>
<td>
<img src='https://github.com/alexmercerind/flutter_media_metadata/blob/assets/android.png?raw=true' height='500'></img>
</td>
<td>
<img src='https://github.com/alexmercerind/flutter_media_metadata/blob/assets/windows_active.png?raw=true' height='500'></img>
</td>
</tr>
</table>

## License 

This library & work under this repository is MIT licensed.

Copyright (C) 2021 Hitesh Kumar Saini <saini123hitesh@gmail.com>
