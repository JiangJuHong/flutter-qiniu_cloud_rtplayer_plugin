import 'package:flutter/services.dart';

import '../def.dart';

/// 七牛云RTC插件推流视图控制器
class QiniuCloudRtplayerViewController {
  /// 方法管道
  late final MethodChannel methodChannel;

  /// 监听器对象
  final List<ValueChanged<dynamic>> _listener = [];

  QiniuCloudRtplayerViewController(int viewId) {
    methodChannel = MethodChannel("${QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE}+$viewId");
    methodChannel.setMethodCallHandler(_methodCallHandler);
  }

  /// 平台方法调用绑定
  Future<dynamic> _methodCallHandler(MethodCall call) async {
    // 方法回调
    if (call.method == QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME) {
      for (var listener in _listener) {
        listener(call.arguments);
      }
    }
  }

  /// 添加监听器
  void addListener(ValueChanged<dynamic> listener) => _listener.add(listener);

  /// 移除监听器
  void removeListener(ValueChanged<dynamic> listener) => _listener.remove(listener);

  /// 播放
  Future<void> player({required String url, bool httpPost = true, bool? forceReset}) => methodChannel.invokeMethod("player", {"url": url, "httpPost": httpPost, "forceReset": forceReset});

  /// 播放
  Future<void> stopPlay() => methodChannel.invokeMethod("stopPlay");
}
