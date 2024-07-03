import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:qiniu_cloud_rtplayer_plugin/qiniu_cloud_rtplayer_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 视图控制器
  QiniuCloudRtplayerViewController? _controller;

  @override
  void initState() {
    super.initState();
  }

  /// 视图创建事件
  void _onViewCreated(int viewId) {
    _controller = QiniuCloudRtplayerViewController(viewId);
    _controller!.addListener((params) {
      print("listener:$params");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Expanded(child: QiniuCloudRtplayerView(onViewCreated: _onViewCreated)),
            TextButton(onPressed: () => _controller!.player(httpPost: false, forceReset: false, url: "https://pili-live-hls.zqsq-test.huic.top/zqsq-dev/1808450709629345792.m3u8?sign=8397209d0d57aa717b82cda859ca1d1e&t=668538b4"), child: Text("Player")),
            TextButton(onPressed: () => _controller!.stopPlay(), child: Text("stopPlay")),
          ],
        ),
      ),
    );
  }
}
