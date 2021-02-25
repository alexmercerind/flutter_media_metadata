#include <map>
#include <string>
#include <vector>
#include <iostream>

#include <MediaInfoDLL/MediaInfoDLL.h>


const std::map<std::string, std::string> METADATA_KEYS = {
    {"trackName", "Track"},
    {"trackArtistNames", "Performer"},
    {"albumName", "Album"},
    {"albumArtistName", "Album/Performer"},
    {"trackNumber", "Track/Position"},
    {"albumLength", "Track/Position_Total"},
    {"year", "Recorded_Date"},
    {"genre", "Genre"},
    {"writerName", "WrittenBy"},
    {"trackDuration", "Duration"},
    {"bitrate", "OverallBitRate"},
};


class MediaInfo: public MediaInfoDLL::MediaInfo {
    public:
    void open(std::string fileName) {
        this->Option(L"Cover_Data", L"base64");
        this->Open(this->convert<std::string, std::wstring>(fileName));
    }

    std::string get(std::string key) {
        std::wstring value = this->Get(MediaInfoDLL::Stream_General, 0, convert<std::string, std::wstring>(key));
        return convert<std::wstring, std::string>(value);
    }

    private:
    template<typename U, typename V>
    V convert(U string) {
        return V(string.begin(), string.end());
    }
};


class MetadataRetriever {
    protected:
    MediaInfo *retriever;

    public:
    MetadataRetriever() {
        this->retriever = new MediaInfo();
    }

    void setFilePath(std::string fileName) {
        this->retriever->open(fileName);
    }

    std::map<std::string, std::string> getMetadata() {
        std::map<std::string, std::string> metadata;
        for (const auto& keys: METADATA_KEYS) {
            metadata[keys.first] = this->retriever->get(keys.second);
        }
        return metadata;
    }

    std::string getAlbumArt() {
        if (this->retriever->get("Cover") == "Yes") {
            std::string albumArt = this->retriever->get("Cover_Data");
            return albumArt;
        }
        else return "";
    }
};