/*
 * MIT License
 *
 * Copyright (c) 2021 Hitesh Kumar Saini
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#include <base64.hpp>

#include "metadata_retriever.hpp"
#include "utils.hpp"

static const std::map<std::string, std::wstring> kMetadataKeys = {
    {"trackName", L"Track"},
    {"trackArtistNames", L"Performer"},
    {"albumName", L"Album"},
    {"albumArtistName", L"Album/Performer"},
    {"trackNumber", L"Track/Position"},
    {"albumLength", L"Track/Position_Total"},
    {"year", L"Recorded_Date"},
    {"genre", L"Genre"},
    {"writerName", L"WrittenBy"},
    {"trackDuration", L"Duration"},
    {"bitrate", L"OverallBitRate"},
};

MetadataRetriever::MetadataRetriever() { Option(L"Cover_Data", L"base64"); }

void MetadataRetriever::SetFilePath(std::string file_path) {
  Open(TO_WIDESTRING(file_path));
  for (auto & [ property, key ] : kMetadataKeys) {
    std::string value = TO_STRING(Get(MediaInfoDLL::Stream_General, 0, key));
    metadata_->insert(std::make_pair(property, value));
  }
  metadata_->insert(std::make_pair("filePath", file_path));
  try {
    if (Get(MediaInfoDLL::Stream_General, 0, L"Cover") == L"Yes") {
      std::vector<uint8_t> decoded_album_art = Base64Decode(
          TO_STRING(Get(MediaInfoDLL::Stream_General, 0, L"Cover_Data")));
      album_art_.reset(new std::vector<uint8_t>(decoded_album_art));
      // Apparently libmediainfo already handles the seeking of album art
      // buffer in FLAC.
      // Its a bug in libmediainfo itself that it doesn't seek
      // METADATA_BLOCK_PICTURE in OGG & assigns it to "Cover_Data" itself.
      //
      // Letting following header seeking code stay for OGG until they fix it.
      // Further reference:
      // https://github.com/harmonoid/harmonoid/issues/76
      // https://github.com/MediaArea/MediaInfoLib/pull/1098
      //
      if (Strings::Split(Strings::ToUpperCase(file_path), ".").back() ==
          "OGG") {
        uint8_t* data = decoded_album_art.data();
        size_t size = decoded_album_art.size();
        size_t header = 0;
        uint32_t length = 0;
        RM(4);
        length = U32_AT(data);
        header += length;
        RM(4);
        RM(length);
        length = U32_AT(data);
        header += length;
        RM(4);
        RM(length);
        RM(4 * 4);
        length = U32_AT(data);
        RM(4);
        header += 32;
        size = length;
        album_art_.reset(new std::vector(data, data + length));
      }
    } else {
      album_art_ = nullptr;
    }
  } catch (...) {
    std::cout << "OGG" << std::endl;
    album_art_ = nullptr;
  }
}

MetadataRetriever::~MetadataRetriever() {}
