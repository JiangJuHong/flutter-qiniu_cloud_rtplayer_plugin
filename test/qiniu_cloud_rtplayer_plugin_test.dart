import 'package:flutter_test/flutter_test.dart';
import 'package:qiniu_cloud_rtplayer_plugin/qiniu_cloud_rtplayer_plugin.dart';
import 'package:qiniu_cloud_rtplayer_plugin/qiniu_cloud_rtplayer_plugin_platform_interface.dart';
import 'package:qiniu_cloud_rtplayer_plugin/qiniu_cloud_rtplayer_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQiniuCloudRtplayerPluginPlatform
    with MockPlatformInterfaceMixin
    implements QiniuCloudRtplayerPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QiniuCloudRtplayerPluginPlatform initialPlatform = QiniuCloudRtplayerPluginPlatform.instance;

  test('$MethodChannelQiniuCloudRtplayerPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQiniuCloudRtplayerPlugin>());
  });

  test('getPlatformVersion', () async {
    QiniuCloudRtplayerPlugin qiniuCloudRtplayerPlugin = QiniuCloudRtplayerPlugin();
    MockQiniuCloudRtplayerPluginPlatform fakePlatform = MockQiniuCloudRtplayerPluginPlatform();
    QiniuCloudRtplayerPluginPlatform.instance = fakePlatform;

    expect(await qiniuCloudRtplayerPlugin.getPlatformVersion(), '42');
  });
}
