#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include "include/flutter_media_metadata/flutter_media_metadata_plugin.h"
#include "include/flutter_media_metadata/flutter_types.hpp"

#include "include/flutter_media_metadata/MetadataRetriever.hpp"


#define FLUTTER_MEDIA_METADATA_PLUGIN(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), flutter_media_metadata_plugin_get_type(), FlutterMediaMetadataPlugin))


struct _FlutterMediaMetadataPlugin {
    GObject parent_instance;
};


G_DEFINE_TYPE(FlutterMediaMetadataPlugin, flutter_media_metadata_plugin, g_object_get_type())

MetadataRetriever* retriever = new MetadataRetriever();

static void flutter_media_metadata_plugin_handle_method_call(FlutterMediaMetadataPlugin* self, FlMethodCall* method_call) {
    Method method(method_call);
    if (method.name == "setFilePath") {
        std::string filePath = method.getArgument<std::string>("filePath");
        retriever->setFilePath(filePath);
        method.returnNull();
    }
    else if (method.name == "getMetadata") {
        std::map<std::string, std::string> metadata = retriever->getMetadata();
        method.returnValue<std::map<std::string, std::string>>(metadata);
    }
    else if (method.name == "getAlbumArt") {
        std::string albumArt = retriever->getAlbumArt();
        if (albumArt != "") method.returnValue<std::string>(albumArt);
        else method.returnNull();
    }
    else {
        method.returnNotImplemented();
    }
    method.returnResult();
}

static void flutter_media_metadata_plugin_dispose(GObject* object) {
    G_OBJECT_CLASS(flutter_media_metadata_plugin_parent_class)->dispose(object);
}

static void flutter_media_metadata_plugin_class_init(FlutterMediaMetadataPluginClass* klass) {
    G_OBJECT_CLASS(klass)->dispose = flutter_media_metadata_plugin_dispose;
}

static void flutter_media_metadata_plugin_init(FlutterMediaMetadataPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call, gpointer user_data) {
    FlutterMediaMetadataPlugin* plugin = FLUTTER_MEDIA_METADATA_PLUGIN(user_data);
    flutter_media_metadata_plugin_handle_method_call(plugin, method_call);
}

void flutter_media_metadata_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
    FlutterMediaMetadataPlugin* plugin = FLUTTER_MEDIA_METADATA_PLUGIN(g_object_new(flutter_media_metadata_plugin_get_type(), nullptr));
    g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
    g_autoptr(FlMethodChannel) channel = fl_method_channel_new(
        fl_plugin_registrar_get_messenger(registrar),
        "flutter_media_metadata",
        FL_METHOD_CODEC(codec)
    );
    fl_method_channel_set_method_call_handler(
        channel,
        method_call_cb,
        g_object_ref(plugin),
        g_object_unref
    );
    g_object_unref(plugin);
}
