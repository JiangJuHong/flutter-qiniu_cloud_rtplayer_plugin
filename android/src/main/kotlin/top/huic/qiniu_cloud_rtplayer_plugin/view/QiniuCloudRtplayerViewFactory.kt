package top.huic.qiniu_cloud_rtplayer_plugin.view

import android.content.Context
import android.view.View
import com.qiniu.droid.rtplayer.QNRTPlayer
import com.qiniu.droid.rtplayer.QNRTPlayerFactory
import com.qiniu.droid.rtplayer.QNRTPlayerSetting
import com.qiniu.droid.rtplayer.QNRTPlayerUrl
import com.qiniu.droid.rtplayer.render.QNSurfaceView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.MethodChannel.Result
import org.webrtc.ContextUtils.getApplicationContext
import top.huic.qiniu_cloud_rtplayer_plugin.QiniuCloudRtplayerDef
import top.huic.qiniu_cloud_rtplayer_plugin.QiniuCloudRtplayerEventListener


/**
 * 七牛云RTC Push视图组件工厂
 * @param messenger 订阅事件
 */
class QiniuCloudRtplayerViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val view = QiniuClouqiniudRtplayerView(context!!)
        val channel = MethodChannel(this.messenger, QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE + "+" + viewId)
        view.init(channel, context, args, viewId)
        channel.setMethodCallHandler(view)
        return view;
    }

    /**
     * 七牛云RTC Push视图组件
     * @param context 全局上下文
     */
    class QiniuClouqiniudRtplayerView(context: Context) : PlatformView, MethodChannel.MethodCallHandler {

        /**
         * 消息通道
         */
        private var channel: MethodChannel? = null

        /**
         * 视图对象
         */
        private val view = QNSurfaceView(context)

        /**
         * 七牛云播放器
         */
        private var mRTPlayer: QNRTPlayer? = null

        override fun getView(): View {
            return view
        }

        override fun dispose() {
            if (mRTPlayer != null) mRTPlayer!!.releasePlayer()
        }

        override fun onMethodCall(call: MethodCall, result: Result) {
            this::class.java.getMethod(call.method, MethodCall::class.java, Result::class.java).invoke(this, call, result)
        }

        /**
         * 初始化视图组件
         */
        fun init(channel: MethodChannel, context: Context?, args: Any?, viewId: Int) {
            val setting = QNRTPlayerSetting()

            this.channel = channel

            // 创建播放器
            mRTPlayer = QNRTPlayerFactory.createQNRTPlayer(context)
            mRTPlayer!!.setEventListener(QiniuCloudRtplayerEventListener(this.channel!!))
            mRTPlayer!!.initPlayer(setting)
            mRTPlayer!!.setSurfaceRenderWindow(view)
        }

        fun player(call: MethodCall, result: Result) {
            val url = QNRTPlayerUrl()
            url.setURL(call.argument<String>("url")!!)
            if (call.hasArgument("httpPost")) url.setHttpPost(call.argument<Boolean>("httpPost")!!)
            if (call.hasArgument("forceReset")) url.setForceReset(call.argument<Boolean>("forceReset")!!)
            mRTPlayer!!.playUrl(url)
            result.success(null)
        }

        fun stopPlay(call: MethodCall, result: Result) {
            mRTPlayer!!.stopPlay()
            result.success(null)
        }
    }
}