#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint gt_onelogin_flutter_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'gt_onelogin_flutter_plugin'
  s.version          = '0.0.1'
  s.summary          = 'The official OneLoginSDK flutter plugin project for geetest.'
  s.description      = <<-DESC
The official flutter plugin project for geetest OneLoginSDK.
                       DESC
  s.homepage         = 'https://www.geetest.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Geetest' => 'xuwei@geetest.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'OneLoginSDK-iOS'
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 i386' }
  s.swift_version = '5.0'
end
