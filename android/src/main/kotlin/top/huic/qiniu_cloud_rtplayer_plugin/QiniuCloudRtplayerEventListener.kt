package top.huic.qiniu_cloud_rtplayer_plugin

import com.qiniu.droid.rtplayer.QNError
import com.qiniu.droid.rtplayer.QNRTPlayer
import io.flutter.plugin.common.MethodChannel

/**
 * 七牛云事件监听器
 */
class QiniuCloudRtplayerEventListener(private var channel: MethodChannel) : QNRTPlayer.EventListener {
    override fun onPlayerStateChanged(p0: Int) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, mutableMapOf("type" to "stateChange", "state" to p0))
    }

    override fun onPlayerInfo(p0: Int, p1: Any?) {
        // java.lang.IllegalArgumentException: Unsupported value: '1280x720' of type 'class com.qiniu.droid.rtplayer.QNSize'
        // channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, mutableMapOf("type" to "info", "args" to mutableMapOf("type" to p0, "info" to p1)))
    }

    override fun onPlayerError(p0: QNError?) {
        channel.invokeMethod(QiniuCloudRtplayerDef.LISTENER_INVOKE_NAME, mutableMapOf("type" to "error", "code" to p0!!.mCode, "message" to p0.mDescription))
    }
}