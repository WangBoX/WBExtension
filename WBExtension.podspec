

Pod::Spec.new do |s|
  s.name             = 'WBExtension'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WBExtension.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/WangBoX/WBExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WangBoX' => '563915318@qq.com' }
  s.source           = { :git => 'https://github.com/WangBoX/WBExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.dependency 'FMDB'
  s.dependency 'Masonry'
  s.dependency 'YYCache'
  s.dependency 'YYText' 
  s.dependency 'SDWebImage', '3.8.0'

  s.source_files = 'WBExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WBExtension' => ['WBExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

end
