package top.huic.qiniu_cloud_rtplayer_plugin

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import top.huic.qiniu_cloud_rtplayer_plugin.view.QiniuCloudRtplayerViewFactory

/** QiniuCloudRtplayerPlugin */
class QiniuCloudRtplayerPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val binaryMessenger = flutterPluginBinding.binaryMessenger;

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qiniu_cloud_rtplayer_plugin")
        channel.setMethodCallHandler(this)

        // 注册View
        flutterPluginBinding.platformViewRegistry.registerViewFactory(QiniuCloudRtplayerDef.VIEW_PLAYER_PLATFORM_VIEW_TYPE, QiniuCloudRtplayerViewFactory(binaryMessenger))
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        result.notImplemented()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
