import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiniu_cloud_rtplayer_plugin/def.dart';

/// 七牛云RTPlayer视图组建
class QiniuCloudRtplayerView extends StatelessWidget {
  /// 视图创建事件
  final ValueChanged<int>? onViewCreated;

  const QiniuCloudRtplayerView({super.key, this.onViewCreated});

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE,
        creationParams: {},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: onViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE,
        creationParams: {},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: onViewCreated,
      );
    } else {
      return const Text("This platform is not currently supported.");
    }
  }
}
