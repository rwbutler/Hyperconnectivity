Pod::Spec.new do |s|
  s.name             = 'Hyperconnectivity'
  s.version          = '1.2.1'
  s.swift_version    = '5.0'
  s.summary          = 'Modern replacement for Apple\'s Reachability written in Swift and made elegant using Combine'
  s.description      = <<-DESC
  Hyperconnectivity provides Internet connectivity and captive portal detection in Swift using Combine.
                       DESC
  s.homepage         = 'https://github.com/rwbutler/Hyperconnectivity'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ross Butler' => 'github@rwbutler.com' }
  s.source           = { :git => 'https://github.com/rwbutler/Hyperconnectivity.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ross_w_butler'
  s.ios.deployment_target = '13.0'
  s.frameworks      = 'Combine', 'Network'
  s.source_files = 'Hyperconnectivity/Classes/**/*'
end
