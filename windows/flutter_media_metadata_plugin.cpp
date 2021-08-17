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
#include "include/flutter_media_metadata/flutter_media_metadata_plugin.h"

#include <future>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include "../cxx/metadata_retriever.hpp"

namespace {

class FlutterMediaMetadataPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

  FlutterMediaMetadataPlugin();

  virtual ~FlutterMediaMetadataPlugin();

 private:
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

void FlutterMediaMetadataPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "flutter_media_metadata",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterMediaMetadataPlugin>();

  channel->SetMethodCallHandler([plugin_pointer = plugin.get()](
      const auto& call, auto result) {
    plugin_pointer->HandleMethodCall(call, std::move(result));
  });

  registrar->AddPlugin(std::move(plugin));
}

FlutterMediaMetadataPlugin::FlutterMediaMetadataPlugin() {}

FlutterMediaMetadataPlugin::~FlutterMediaMetadataPlugin() {}

void FlutterMediaMetadataPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("MetadataRetriever") == 0) {
    auto arguments = std::get<flutter::EncodableMap>(*method_call.arguments());
    auto file_path =
        std::get<std::string>(arguments[flutter::EncodableValue("filePath")]);
    std::future<void> future =
        std::async([ =, result_ptr = std::move(result) ]()->void {
          std::unique_ptr<MetadataRetriever> retriever =
              std::make_unique<MetadataRetriever>();
          retriever->SetFilePath(file_path);
          flutter::EncodableMap metadata;
          for (const auto & [ key, value ] : *retriever->metadata()) {
            metadata.insert(std::make_pair(flutter::EncodableValue(key),
                                           flutter::EncodableValue(value)));
          }
          flutter::EncodableMap response;
          response.insert(std::make_pair("metadata", metadata));
          if (retriever->album_art() != nullptr)
            response.insert(
                std::make_pair("albumArt", *retriever->album_art()));
          result_ptr->Success(flutter::EncodableValue(response));
        });
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void FlutterMediaMetadataPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  FlutterMediaMetadataPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
