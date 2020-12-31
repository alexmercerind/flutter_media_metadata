package com.alexmercerind.media_metadata_retriever;

import android.media.MediaMetadataRetriever;
import java.util.HashMap;


public class DerivedMetadataRetriever extends MediaMetadataRetriever {
    public DerivedMetadataRetriever() {
        super();
    }

    public void setFilePath(String filePath) {
        this.setDataSource(filePath);
    }

    public void setUri(String uri, HashMap<String, String> headers) {
        this.setDataSource(uri, headers);
    }

    public HashMap<String, String> getMetadata() {
        HashMap<String, String> metadata = new HashMap<String, String>();
        metadata.put("title"      , this.getValue(this.METADATA_KEY_TITLE          , "Unknown Title"));
        metadata.put("album"      , this.getValue(this.METADATA_KEY_ALBUM          , "Unknown Album"));
        metadata.put("artists"    , this.getValue(this.METADATA_KEY_ARTIST         , "Unknown Artist"));
        metadata.put("year"       , this.getValue(this.METADATA_KEY_YEAR           , "Unknown Year"));
        metadata.put("trackNumber", this.getValue(this.METADATA_KEY_CD_TRACK_NUMBER, "1/1"));
        metadata.put("albumArtist", this.getValue(this.METADATA_KEY_ALBUMARTIST    , "Unknown Artist"));
        metadata.put("genre"      , this.getValue(this.METADATA_KEY_GENRE          , "Unknown Genre"));
        metadata.put("author"     , this.getValue(this.METADATA_KEY_AUTHOR         , "Unknown Author"));
        metadata.put("writer"     , this.getValue(this.METADATA_KEY_WRITER         , "Unknown Writer"));
        metadata.put("discNumber" , this.getValue(this.METADATA_KEY_DISC_NUMBER    , "Unknown Disc Number"));
        metadata.put("mimeType"   , this.getValue(this.METADATA_KEY_MIMETYPE       , "Unknown Mime Type"));
        return metadata;
    }

    public byte[] getAlbumArt() {
        return this.getEmbeddedPicture();
    }

    public int getDuration() {
        return Integer.parseInt(this.extractMetadata(this.METADATA_KEY_DURATION));
    }

    public int getBitrate() {
        return Integer.parseInt(this.extractMetadata(this.METADATA_KEY_BITRATE));
    }

    private String getValue(int metadataKey, String defaultValue) {
        String value = this.extractMetadata(metadataKey);
        return value != null ? value : defaultValue;
    }
}
