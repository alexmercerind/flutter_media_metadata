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
#ifndef UNICODE
#define UNICODE
#endif
#include <iostream>
#include <string>
#include <vector>
#include <map>

#include <MediaInfoDLL/MediaInfoDLL.hpp>

#ifndef METADATA_RETRIEVER_HEADER
#define METADATA_RETRIEVER_HEADER

class MetadataRetriever : public MediaInfoDLL::MediaInfo {
 public:
  MetadataRetriever();

  std::map<std::string, std::string>& metadata() { return metadata_; }
  std::vector<uint8_t>& album_art() { return album_art_; }

  void SetFilePath(std::string file_path);

  ~MetadataRetriever();

 private:
  std::map<std::string, std::string> metadata_;
  std::vector<uint8_t> album_art_;
};

#endif
