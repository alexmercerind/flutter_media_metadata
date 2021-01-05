package com.alexmercerind.media_metadata_retriever;

import android.media.MediaMetadataRetriever;
import java.util.Arrays;
import java.util.ArrayList;
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

    public HashMap<String, Object> getMetadata() {
        HashMap<String, Object> metadata = new HashMap<String, Object>();
        String trackName = this.extractMetadata(this.METADATA_KEY_TITLE);
        if (trackName != null) {
            metadata.put("trackName", trackName);
        }
        else {
            metadata.put("trackName", null);
        }
        String trackArtistNames = this.extractMetadata(this.METADATA_KEY_ARTIST);
        if (trackArtistNames != null) {
            metadata.put("trackArtistNames", new ArrayList<String>(Arrays.asList(trackArtistNames.split("/"))));
        }
        else {
            metadata.put("trackArtistNames", null);
        }
        String albumName = this.extractMetadata(this.METADATA_KEY_ALBUM);
        if (albumName != null) {
            metadata.put("albumName", albumName);
        }
        else {
            metadata.put("trackName", null);
        }
        String albumArtistName = this.extractMetadata(this.METADATA_KEY_ALBUMARTIST);
        if (albumArtistName != null) {
            metadata.put("albumArtistName", albumArtistName);
        }
        else {
            metadata.put("albumArtistName", null);
        }
        String trackNumber = this.extractMetadata(this.METADATA_KEY_CD_TRACK_NUMBER);
        if (trackNumber != null) {
            try {
                metadata.put("trackNumber", Integer.parseInt(trackNumber.split("/")[0].trim()));
                metadata.put("albumLength", Integer.parseInt(trackNumber.split("/")[trackNumber.split("/").length - 1].trim()));
            }
            catch (Exception error) {
                metadata.put("trackNumber", null);
                metadata.put("albumLength", null);
            }
        }
        else {
            metadata.put("trackNumber", null);
            metadata.put("albumLength", null);
        }
        String year = this.extractMetadata(this.METADATA_KEY_YEAR);
        String date = this.extractMetadata(this.METADATA_KEY_DATE);
        if (year != null) {
            try {
                metadata.put("year", Integer.parseInt(year.trim()));
            }
            catch (Exception error) {
                metadata.put("year", null);
            }
        }
        else if (date != null) {
            try {
                metadata.put("year", Integer.parseInt(date.split("-")[0].trim()));
            }
            catch (Exception error) {
                metadata.put("year", null);
            }
        }
        else {
            metadata.put("year", null);
        }
        String genre = this.extractMetadata(this.METADATA_KEY_GENRE);
        if (genre != null) {
            metadata.put("genre", genre);
        }
        else {
            metadata.put("genre", null);
        }
        String authorName = this.extractMetadata(this.METADATA_KEY_AUTHOR);
        if (authorName != null) {
            metadata.put("authorName", authorName);
        }
        else {
            metadata.put("authorName", null);
        }
        String writerName = this.extractMetadata(this.METADATA_KEY_WRITER);
        if (writerName != null) {
            metadata.put("writerName", writerName);
        }
        else {
            metadata.put("writerName", null);
        }
        String discNumber = this.extractMetadata(this.METADATA_KEY_DISC_NUMBER);
        if (discNumber != null) {
            try {
                metadata.put("discNumber", Integer.parseInt(discNumber.trim()));
            }
            catch(Exception error) {
                metadata.put("trackDuration", null);
            }
        }
        else {
            metadata.put("discNumber", null);
        }
        String mimeType = this.extractMetadata(this.METADATA_KEY_MIMETYPE);
        if (mimeType != null) {
            metadata.put("mimeType", mimeType);
        }
        else {
            metadata.put("mimeType", null);
        }
        String duration = this.extractMetadata(this.METADATA_KEY_DURATION);
        if (duration != null) {
            try {
                metadata.put("trackDuration", (int)(Integer.parseInt(duration.trim()) / 1000));
            }
            catch(Exception error) {
                metadata.put("trackDuration", null);
            }
        }
        else {
            metadata.put("trackDuration", null);
        }
        String bitrate = this.extractMetadata(this.METADATA_KEY_BITRATE);
        if (bitrate != null) {
            try {
                metadata.put("bitrate", (int)(Integer.parseInt(bitrate.trim()) / 1000));
            }
            catch (Exception error) {
                metadata.put("bitrate", null);
            }
        }
        else {
            metadata.put("bitrate", null);
        }
        return metadata;
    }

    public byte[] getAlbumArt() {
        return this.getEmbeddedPicture();
    }
}
