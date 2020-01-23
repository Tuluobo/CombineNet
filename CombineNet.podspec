Pod::Spec.new do |s|
    s.name             = 'CombineNet'
    s.version          = '0.0.1'
    s.swift_version    = '5.0'
    s.summary          = 'CombineNet is a lightweight, combine network framework.'
  
  
    s.homepage         = 'https://github.com/Tuluobo/CombineNet'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Tuluobo' => 'tuluobo@vip.qq.com' }
    s.source           = { :git => 'https://github.com/Tuluobo/CombineNet.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '13.0'
    s.osx.deployment_target = '10.15'
  
    s.source_files = 'Sources/**/*.swift'
    s.requires_arc = true
  
  end