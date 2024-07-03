
import 'qiniu_cloud_rtplayer_plugin_platform_interface.dart';

class QiniuCloudRtplayerPlugin {
  Future<String?> getPlatformVersion() {
    return QiniuCloudRtplayerPluginPlatform.instance.getPlatformVersion();
  }
}
