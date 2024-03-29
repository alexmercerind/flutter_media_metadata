## 0.1.1

- Added Windows support.
- Moved `MediaMetadataRetriever.setDataSource` & `MediaMetadataRetriever.extractMetadata` calls to another non-UI thread on Android.
- Improved Linux support.
- Added support for embedded album arts on Windows & Linux.
- Changed API to single call, `MetadataRetriever.fromFile`.

## 0.1.0

- Migrated to null-safety
- `trackArtistNames` is now `List<String>` instead of `List<dynamic>`

## 0.0.3+2

- Update documentation.

## 0.0.3

- [media_metadata_retriever](https://github.com/alexmercerind/flutter_media_metadata) is now [flutter_media_metadata](https://github.com/alexmercerind/media_metadata_retriever).
- Added Linux support with album arts.
- Uses [MediaInfoLib](https://github.com/MediaArea/MediaInfoLib) on Linux.

## 0.0.1+4

- Updated Metadata class structure.
- Now bitrate & duration in stored in Metadata itself.

## 0.0.1+3
- More minor changes.

## 0.0.1+2

- Minor updates to documentation.

## 0.0.1

This first version of media_metadata_retriever adds:
- Support for retriving metadata of a media file in Android.
- Uses [MediaMetadataRetriever](https://developer.android.com/reference/android/media/MediaMetadataRetriever).
