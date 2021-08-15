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
    metadata_.insert(std::make_pair(property, value));
  }
  try {
    auto album_art_base64 = Get(MediaInfoDLL::Stream_General, 0, L"Cover_Data");
    album_art_ = Base64Decode(TO_STRING(album_art_base64));
    // TODO (alexmercerind): Improve METADATA_BLOCK_PICTURE extraction.
    if (Strings::Split(Strings::ToUpperCase(file_path), ".").back() == "OGG" ||
        Strings::Split(Strings::ToUpperCase(file_path), ".").back() == "FLAC") {
      uint8_t* data = album_art_.data();
      size_t size = album_art_.size();
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
      album_art_ = std::vector(data, data + length);
    }
  } catch (...) {
  }
}

MetadataRetriever::~MetadataRetriever() {}
