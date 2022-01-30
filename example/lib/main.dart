import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF121212),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'flutter_media_metadata',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FilePicker.platform.pickFiles()
            ..then(
              (result) {
                if (result == null) return;
                if (result.count == 0) return;
                if (kIsWeb) {
                  /// Use [MetadataRetriever.fromBytes] on Web.
                  MetadataRetriever.fromBytes(
                    result.files.first.bytes!,
                  )
                    ..then(
                      (metadata) {
                        showData(metadata);
                      },
                    )
                    ..catchError((_) {
                      setState(() {
                        _child = Text('Couldn\'t extract metadata');
                      });
                    });
                } else {
                  /// Use [MetadataRetriever.fromFile] on Windows, Linux, macOS, Android or iOS.
                  MetadataRetriever.fromFile(
                    File(result.files.first.path!),
                  )
                    ..then(
                      (metadata) {
                        showData(metadata);
                      },
                    )
                    ..catchError((_) {
                      setState(() {
                        _child = Text('Couldn\'t extract metadata');
                      });
                    });
                }
              },
            )
            ..catchError((_) {
              setState(() {
                _child = Text('Couldn\'t to select file');
              });
            });
        },
        child: Icon(Icons.file_present),
      ),
      body: Center(
        child: _child ?? Text('Press FAB to open a media file'),
      ),
    );
  }

  void showData(Metadata metadata) {
    setState(() {
      _child = ListView(
        scrollDirection: MediaQuery.of(context).size.height >
                MediaQuery.of(context).size.width
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          if (MediaQuery.of(context).size.height <=
              MediaQuery.of(context).size.width)
            SizedBox(
              width: 16.0,
            ),
          metadata.albumArt == null
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                  width: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                  child: Text('null'),
                )
              : Image.memory(
                  metadata.albumArt!,
                  height: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                  width: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.width
                      : 256.0,
                ),
          SizedBox(
            width: 16.0,
          ),
          SingleChildScrollView(
            scrollDirection: MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width
                ? Axis.horizontal
                : Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Property',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Value',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('trackName')),
                    DataCell(Text('${metadata.trackName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('trackArtistNames')),
                    DataCell(Text('${metadata.trackArtistNames}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('albumName')),
                    DataCell(Text('${metadata.albumName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('albumArtistName')),
                    DataCell(Text('${metadata.albumArtistName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('trackNumber')),
                    DataCell(Text('${metadata.trackNumber}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('albumLength')),
                    DataCell(Text('${metadata.albumLength}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('year')),
                    DataCell(Text('${metadata.year}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('genre')),
                    DataCell(Text('${metadata.genre}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('authorName')),
                    DataCell(Text('${metadata.authorName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('writerName')),
                    DataCell(Text('${metadata.writerName}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('discNumber')),
                    DataCell(Text('${metadata.discNumber}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('mimeType')),
                    DataCell(Text('${metadata.mimeType}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('trackDuration')),
                    DataCell(Text('${metadata.trackDuration}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('bitrate')),
                    DataCell(Text('${metadata.bitrate}')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('filePath')),
                    DataCell(Text('${metadata.filePath}')),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
