import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qiniu_cloud_rtplayer_plugin_platform_interface.dart';

/// An implementation of [QiniuCloudRtplayerPluginPlatform] that uses method channels.
class MethodChannelQiniuCloudRtplayerPlugin extends QiniuCloudRtplayerPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qiniu_cloud_rtplayer_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
