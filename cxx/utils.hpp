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
#include <string>
#include <vector>
#include <algorithm>

#ifndef UTILS_HEADER
#define UTILS_HEADER

#define RM(x) \
  \
size -= (x);  \
  \
data += (x);

static inline uint32_t U32_AT(const void* data) {
  uint32_t x;
  memcpy(&x, data, sizeof(x));
#ifdef _WIN32
  return ((x & 0x000000FF) << 24) | ((x & 0x0000FF00) << 8) |
         ((x & 0x00FF0000) >> 8) | ((x & 0xFF000000) >> 24);
#else
  return __builtin_bswap32(x);
#endif
}

#ifdef _WIN32
char* strndup(const char* array, size_t size) {
  char* buffer;
  size_t n;
  buffer = (char*)malloc(size + 1);
  if (buffer) {
    for (n = 0; ((n < size) && (array[n] != 0)); n++) buffer[n] = array[n];
    buffer[n] = 0;
  }
  return buffer;
}
#endif

auto TO_WIDESTRING = [](std::string string) -> std::wstring {
  return std::wstring(string.begin(), string.end());
};

auto TO_STRING = [](std::wstring wide_string) -> std::string {
  return std::string(wide_string.begin(), wide_string.end());
};

class Strings {
 public:
  static inline bool StartsWith(std::string string, std::string subString) {
    if (string.substr(0, subString.size()) == subString)
      return true;
    else
      return false;
  }

  static inline std::vector<std::string> Split(std::string string,
                                               std::string match) {
    std::vector<std::string> result = {};
    size_t match_size = match.size();
    size_t last = 0;
    for (int index = 0; index < string.size(); index++) {
      if (string.substr(index, match_size) == match) {
        result.emplace_back(string.substr(last, index - last));
        last = match_size + index;
      }
    }
    result.emplace_back(string.substr(last, string.size()));
    return result;
  }

  static inline std::string Replace(std::string string, std::string match,
                                    std::string replace) {
    std::string result;
    size_t match_size = match.size();
    size_t last_index = 0;
    size_t match_counter = 0;
    for (int index = 0; index < string.size(); index++) {
      if (match_counter != 0) {
        if (match_counter == match.size() - 1)
          match_counter = 0;
        else
          match_counter++;
      } else if (index == string.size() - match.size()) {
        result.append(replace);
        break;
      } else if (string.substr(index, match_size) == match &&
                 match_counter == 0) {
        result.append(replace);
        last_index = match_size + index;
        match_counter++;
      } else {
        result.push_back(string[index]);
      }
    }
    return result;
  }

  static inline std::string ToUpperCase(std::string& string) {
    std::transform(string.begin(), string.end(), string.begin(), ::toupper);
    return string;
  }
};

#endif