package com.alexmercerind.media_metadata_retriever;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.HashMap;


public class MediaMetadataRetrieverPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private DerivedMetadataRetriever metadataRetriever;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "media_metadata_retriever");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("setFilePath")) {
      this.metadataRetriever = new DerivedMetadataRetriever();
      this.metadataRetriever.setFilePath((String)call.argument("filePath"));
      result.success(null);
    }
    else if (call.method.equals("setUri")) {
      this.metadataRetriever = new DerivedMetadataRetriever();
      this.metadataRetriever.setUri((String)call.argument("uri"), (HashMap<String, String>)call.argument("headers"));
      result.success(null);
    }
    else if (call.method.equals("getMetadata")) {
      result.success(this.metadataRetriever.getMetadata());
    }
    else if (call.method.equals("getAlbumArt")) {
      result.success(this.metadataRetriever.getAlbumArt());
    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
