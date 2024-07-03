import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qiniu_cloud_rtplayer_plugin_method_channel.dart';

abstract class QiniuCloudRtplayerPluginPlatform extends PlatformInterface {
  /// Constructs a QiniuCloudRtplayerPluginPlatform.
  QiniuCloudRtplayerPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static QiniuCloudRtplayerPluginPlatform _instance = MethodChannelQiniuCloudRtplayerPlugin();

  /// The default instance of [QiniuCloudRtplayerPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelQiniuCloudRtplayerPlugin].
  static QiniuCloudRtplayerPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QiniuCloudRtplayerPluginPlatform] when
  /// they register themselves.
  static set instance(QiniuCloudRtplayerPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
