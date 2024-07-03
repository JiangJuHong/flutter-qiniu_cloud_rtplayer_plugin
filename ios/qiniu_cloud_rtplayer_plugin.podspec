#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint qiniu_cloud_rtplayer_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'qiniu_cloud_rtplayer_plugin'
  s.version          = '1.0.2'
  s.summary          = '七牛云低延时播放SDK'
  s.description      = <<-DESC
七牛云低延时播放SDK
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
  s.swift_version = '5.0'

  # 七牛云低延时播放SDK v1.0.2，如需更新依赖版本，请前往 https://raw.githubusercontent.com/pili-engineering/QNRTPlayer-iOS/master/QNRTPlayerKit-Universal.podspec 下载最新ZIP版本并替换Framework目录中的QNRTCKit
  s.subspec 'QNRTPlayerKit' do |sp|
    sp.requires_arc            = true
    sp.frameworks = ['UIKit', 'AVFoundation', 'CoreGraphics', 'CFNetwork', 'AudioToolbox', 'CoreMedia', 'VideoToolbox']
    sp.vendored_frameworks = 'Framework/*.framework'
  end
end
