package com.alexmercerind.flutter_media_metadata;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.HashMap;


public class FlutterMediaMetadataPlugin implements FlutterPlugin, MethodCallHandler {
  private MetadataRetriever retriever;
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_media_metadata");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("setFilePath")) {
      this.retriever = new MetadataRetriever();
      this.retriever.setFilePath((String)call.argument("filePath"));
      result.success(null);
    }
    else if (call.method.equals("setUri")) {
      this.retriever = new MetadataRetriever();
      this.retriever.setUri((String)call.argument("uri"), (HashMap<String, String>)call.argument("headers"));
      result.success(null);
    }
    else if (call.method.equals("getMetadata")) {
      result.success(this.retriever.getMetadata());
    }
    else if (call.method.equals("getAlbumArt")) {
      result.success(this.retriever.getAlbumArt());
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
