package com.alexmercerind.flutter_media_metadata;
import android.media.MediaMetadataRetriever;
import java.util.HashMap;
import java.lang.System;

public class MetadataRetriever extends MediaMetadataRetriever {
  public MetadataRetriever() {
    super();
  }

  public void setFilePath(String filePath) {
    this.setDataSource(filePath);
  }

  public HashMap<String, Object> getMetadata() {
    HashMap<String, Object> metadata = new HashMap<String, Object>();
    metadata.put("trackName", this.extractMetadata(this.METADATA_KEY_TITLE));
    metadata.put("trackArtistNames", this.extractMetadata(this.METADATA_KEY_ARTIST));
    metadata.put("albumName", this.extractMetadata(this.METADATA_KEY_ALBUM));
    metadata.put("albumArtistName", this.extractMetadata(this.METADATA_KEY_ALBUMARTIST));
    String trackNumber = this.extractMetadata(this.METADATA_KEY_CD_TRACK_NUMBER);
    try {
      metadata.put("trackNumber", trackNumber.split("/")[0].trim());
      metadata.put("albumLength", trackNumber.split("/")[trackNumber.split("/").length - 1].trim());
    } catch (Exception error) {
      metadata.put("trackNumber", null);
      metadata.put("albumLength", null);
    }
    String year = this.extractMetadata(this.METADATA_KEY_YEAR);
    String date = this.extractMetadata(this.METADATA_KEY_DATE);
    try {
      metadata.put("year", Integer.parseInt(year.trim()));
    } catch (Exception yearException) {
      try {
        metadata.put("year", date.split("-")[0].trim());
      } catch (Exception dateException) {
        metadata.put("year", null);
      }
    }
    metadata.put("genre", this.extractMetadata(this.METADATA_KEY_GENRE));
    metadata.put("authorName", this.extractMetadata(this.METADATA_KEY_AUTHOR));
    metadata.put("writerName", this.extractMetadata(this.METADATA_KEY_WRITER));
    metadata.put("discNumber", this.extractMetadata(this.METADATA_KEY_DISC_NUMBER));
    metadata.put("mimeType", this.extractMetadata(this.METADATA_KEY_MIMETYPE));
    metadata.put("trackDuration", this.extractMetadata(this.METADATA_KEY_DURATION));
    metadata.put("bitrate", this.extractMetadata(this.METADATA_KEY_BITRATE));
    return metadata;
  }

  public byte[] getAlbumArt() {
    return this.getEmbeddedPicture();
  }
}
