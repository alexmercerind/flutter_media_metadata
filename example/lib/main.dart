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
  String mediaFilePath;
  Widget mediaAlbumArt;
  Widget mediaMetadata;

  Future<void> onSelected(String mediaFilePath) async {
    FocusScope.of(context).unfocus();
    var metadataRetriever = new MetadataRetriever();
    await metadataRetriever.setFile(File(mediaFilePath));
    this.metadata = await metadataRetriever.metadata;
    this.setState(() {
      this.mediaAlbumArt = metadataRetriever.albumArt != null
          ? new Image.memory(
              metadataRetriever.albumArt,
              height: 200.0,
              width: 200.0,
            )
          : Container(
              height: 200.0,
              width: 200.0,
              child: Text('No Album Art'),
            );
      this.mediaMetadata = new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Property')),
            DataColumn(label: Text('Value')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('trackName')),
                DataCell(Text('${this.metadata.trackName}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('trackArtistNames')),
                DataCell(Text('${this.metadata.trackArtistNames}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('albumName')),
                DataCell(Text('${this.metadata.albumName}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('albumArtistName')),
                DataCell(Text('${this.metadata.albumArtistName}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('trackNumber')),
                DataCell(Text('${this.metadata.trackNumber}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('albumLength')),
                DataCell(Text('${this.metadata.albumLength}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('year')),
                DataCell(Text('${this.metadata.year}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('genre')),
                DataCell(Text('${this.metadata.genre}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('authorName')),
                DataCell(Text('${this.metadata.authorName}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('writerName')),
                DataCell(Text('${this.metadata.writerName}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('discNumber')),
                DataCell(Text('${this.metadata.discNumber}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('mimeType')),
                DataCell(Text('${this.metadata.mimeType}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('trackDuration')),
                DataCell(Text('${this.metadata.trackDuration}')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('bitrate')),
                DataCell(Text('${this.metadata.bitrate}')),
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('flutter_media_metadata'),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              TextField(
                onEditingComplete: () => this.onSelected(this.mediaFilePath),
                onChanged: (String value) => this.mediaFilePath = value,
                decoration: InputDecoration(
                  labelText: 'File Location',
                  hintText: 'Enter path to a media file.',
                ),
              ),
              RaisedButton(
                onPressed: () => this.onSelected(this.mediaFilePath),
                child: Text('LOAD FILE'),
              ),
              this.mediaAlbumArt ?? Container(),
              this.mediaMetadata ??
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text(
                      'Enter path to a file to get its metadata.\nDo not forget to give storage permissions to the app.',
                      textAlign: TextAlign.center,
                    ),
                  ),
            ],
          )),
    );
  }
}
