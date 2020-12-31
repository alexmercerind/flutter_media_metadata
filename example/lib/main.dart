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

  // Method called after pressing FAB
  Future<void> onSelected(String mediaFilePath) async {
    FocusScope.of(context).unfocus();
    // Instantiating MediaMetadataRetriever class
    var metadataRetriever = new MediaMetadataRetriever();
    // Setting path of media file
    await metadataRetriever.setFile(File(mediaFilePath));
    // Getting Metadata of the media file
    this.metadata = await metadataRetriever.metadata;

    this.setState(() {
      this.mediaAlbumArt = new Image.memory(
        // Getting album art of media file as Uint8List
        metadataRetriever.albumArt,
        height: 200.0,
        width: 200.0,
      );
      // Displaying metadata in a DataTable
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
                DataCell(Text('title')),
                DataCell(Text(this.metadata.title)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('album')),
                DataCell(Text(this.metadata.album)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('artists')),
                DataCell(Text(this.metadata.artists)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('year')),
                DataCell(Text(this.metadata.year)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('trackNumber')),
                DataCell(Text(this.metadata.trackNumber)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('albumLength')),
                DataCell(Text(this.metadata.albumLength)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('albumArtist')),
                DataCell(Text(this.metadata.albumArtist)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('genre')),
                DataCell(Text(this.metadata.genre)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('author')),
                DataCell(Text(this.metadata.author)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('writer')),
                DataCell(Text(this.metadata.writer)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('discNumber')),
                DataCell(Text(this.metadata.discNumber)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('filePath')),
                DataCell(Text(this.metadata.filePath)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('mimeType')),
                DataCell(Text(this.metadata.mimeType)),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('duration')),
                DataCell(Text(metadataRetriever.duration.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('bitrate')),
                DataCell(Text(metadataRetriever.bitrate.toString())),
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
