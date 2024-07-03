//
// Created by 蒋具宏 on 2023/7/13.
//

import Foundation
import Flutter
import QNRTPlayerKit

/// 七牛云视图工厂
class QiniuCloudRtplayerViewFactory: NSObject, FlutterPlatformViewFactory {

    /// 消息绑定器
    private var messenger: FlutterBinaryMessenger;

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger;
    }

    /// 视图创建
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {

        let view = QiniuCloudRtplayerView(frame);

        // 绑定方法监听
        let methodChannel = FlutterMethodChannel(
                name: "\(QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE)+\(viewId)",
                binaryMessenger: messenger
        );
        methodChannel.setMethodCallHandler(view.handle);

        // 初始化
        view.`init`(args, methodChannel);

        return view;
    }

    /**
     *  定义参数解码器
     */
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance();
    }
}

/// 七牛云视图
public class QiniuCloudRtplayerView: NSObject, FlutterPlatformView {

    /// 视图对象
    private var customView: QNRTVideoView;
    
    /// 七牛云播放对象
    private var player : QNRTPlayer?;

    init(_ frame: CGRect) {
        customView = QNRTVideoView()
        customView.frame = frame
    }

    public func view() -> UIView {
        customView
    }

    /// 初始化
    public func `init`(_ args: Any?, _ methodChannel: FlutterMethodChannel) {
        player = QNRTPlayer()
        player!.delegate = QiniuCloudRtplayerListener(methodChannel)
        player!.playView = customView
    }

    /// 方法通道监听器
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        invokeMethod(target: self, method: call.method, call: call, result: result)
    }

    /// 动态调用方法
    public func invokeMethod(target: NSObject, method: String, call: FlutterMethodCall, result: @escaping FlutterResult) {
        let block: @convention(block) (Any?) -> Void = result
        target.perform(NSSelectorFromString(method + "WithCall:result:"), with: call, with: block)
    }
    
    @objc public func player(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args: NSDictionary = call.arguments as! NSDictionary
        var url = args["url"] as! String
        var httpPost = args["httpPost"] as! Bool
        player!.play(with: URL(string: url)!, supportHttps: !httpPost)
        result(nil)
    }
    
    @objc public func stopPlay(call: FlutterMethodCall, result: @escaping FlutterResult) {
        player!.stop()
        result(nil)
    }
}
