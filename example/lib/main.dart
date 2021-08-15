import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_media_metadata/flutter_media_metadata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Metadata metadata;
  String path;
  Widget albumArt;
  Widget table;

  Future<void> onSelected(String path) async {
    FocusScope.of(context).unfocus();
    print(File(path).existsSync());
    var metadata = await MetadataRetriever.fromFile(File(path));
    setState(() {
      albumArt = metadata.albumArt != null
          ? Image.memory(
              metadata.albumArt,
              height: 200.0,
              width: 200.0,
            )
          : Container(
              height: 200.0,
              width: 200.0,
              child: Text('No album art.'),
            );
      table = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: albumArt ?? Container(),
            ),
            SizedBox(
              width: 16.0,
            ),
            DataTable(
              columns: [
                DataColumn(
                    label: Text('Property',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                DataColumn(
                    label: Text('Value',
                        style: TextStyle(fontWeight: FontWeight.w600))),
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
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('flutter_media_metadata'),
        ),
        body: Scrollbar(
          isAlwaysShown: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              Divider(
                color: Colors.transparent,
                height: 16.0,
              ),
              TextField(
                cursorWidth: 1.0,
                onEditingComplete: () => onSelected(path),
                onChanged: (String value) => path = value,
                style: TextStyle(fontSize: 14.0),
                decoration: InputDecoration(
                    hintText: 'Enter media path.',
                    hintStyle: TextStyle(fontSize: 14.0)),
              ),
              Divider(
                color: Colors.transparent,
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => onSelected(path),
                    child: Text('Retrieve Metadata'),
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
                height: 16.0,
              ),
              Divider(
                color: Colors.transparent,
                height: 16.0,
              ),
              table ??
                  Text(
                    'No media opened.',
                    textAlign: TextAlign.center,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
