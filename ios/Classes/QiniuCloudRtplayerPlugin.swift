import Flutter
import UIKit

public class QiniuCloudRtplayerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "qiniu_cloud_rtplayer_plugin", binaryMessenger: registrar.messenger())
    let instance = QiniuCloudRtplayerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      // 注册视图
      registrar.register(QiniuCloudRtplayerViewFactory(messenger: registrar.messenger()), withId: QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(FlutterMethodNotImplemented)
  }
}
