//
// Created by 蒋具宏 on 2024/7/3.
//

import Foundation
import QNRTPlayerKit
import Flutter

/// 常量定义
class QiniuCloudRtplayerListener :NSObject, QNRTPlayerDelegate {
    /// 方法传输管道
    private var channel: FlutterMethodChannel;

    init(_ channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    func rtPlayer(_ player: QNRTPlayer, playStateDidChange playState: QNRTPlayState) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, arguments: [
                    "type": "stateChange",
                    "state": playState.rawValue
                ])
    }
    
    func rtPlayer(_ player: QNRTPlayer, didGetStatistic statistic: [AnyHashable : Any]) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, arguments: [
                    "type": "statistic",
                    "statistic": statistic
                ])
    }
    
    func rtPlayer(_ player: QNRTPlayer, trackDidReceived kind: QNRTSourceKind) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, arguments: [
                    "type": "received",
                    "kind": kind.rawValue
                ])
    }
    
    func rtPlayer(_ player: QNRTPlayer, didFailWithError error: any Error) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, arguments: [
                    "type": "error",
                    "code": error._code,
                    "message": error.localizedDescription
                ])
    }
    
    func rtPlayer(_ player: QNRTPlayer, firstSourceDidDecode kind: QNRTSourceKind) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, arguments: [
                    "type": "decode",
                    "kind": kind.rawValue
                ])
    }
}

