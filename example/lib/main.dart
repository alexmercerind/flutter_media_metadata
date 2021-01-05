import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:media_metadata_retriever/media_metadata_retriever.dart';

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

  // Method called by FAB
  Future<void> onSelected(String mediaFilePath) async {
    FocusScope.of(context).unfocus();
    // Instantiate MediaMetadataRetriever
    var metadataRetriever = new MediaMetadataRetriever();
    // Set file path
    await metadataRetriever.setFile(File(mediaFilePath));
    // Get metadata
    this.metadata = await metadataRetriever.metadata;
    this.setState(() {
      this.mediaAlbumArt = metadataRetriever.albumArt != null
          ? new Image.memory(
              // Get album art
              metadataRetriever.albumArt,
              height: 200.0,
              width: 200.0,
            )
          : Container(
              height: 200.0,
              width: 200.0,
              child: Text('No Album Art'),
            );
      // Display metadata in a DataTable
      this.mediaMetadata = new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text('Property',
                    style: TextStyle(color: Colors.deepPurpleAccent[700]))),
            DataColumn(
                label: Text('Value',
                    style: TextStyle(color: Colors.deepPurpleAccent[700]))),
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
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent[700],
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('media_metadata_retriever'),
          ),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorWidth: 1.0,
                        cursorColor: Colors.deepPurpleAccent[700],
                        onEditingComplete: () =>
                            this.onSelected(this.mediaFilePath),
                        onChanged: (String value) => this.mediaFilePath = value,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          labelText: 'File Location',
                          hintText: 'Enter path to a media file',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.deepPurpleAccent[700])),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.deepPurpleAccent[700])),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.deepPurpleAccent[700])),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: FloatingActionButton(
                        tooltip: 'Get Metadata',
                        onPressed: () => this.onSelected(this.mediaFilePath),
                        child: Icon(Icons.my_library_music),
                        backgroundColor: Colors.deepPurpleAccent[700],
                      ),
                    ),
                  ],
                ),
              ),
              this.mediaAlbumArt ?? Container(),
              this.mediaMetadata ??
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text(
                      'Enter path to a file & tap the FAB to get its metadata.\nDo not forget to give storage permissions to the app',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
            ],
          )),
    );
  }
}
