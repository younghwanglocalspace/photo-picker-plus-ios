Pod::Spec.new do |s|
  s.name         = "PhotoPickerPlus"
  s.version      = "2.3.1"
  s.summary      = "iOS component for picking photos from the iDevice & web using the Chute Platform."
  s.homepage     = "http://www.getchute.com"
  s.license      = {:type => 'MIT'}
  s.author       = { "Oliver Dimitrov" => "oliver.dimitrov@getchute.com" }
  s.source       = { :git => "https://github.com/chute/photo-picker-plus-ios.git", :tag => "2.3.1" } 
  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'PhotoPickerPlus', 'PhotoPickerPlus/**/*.{h,m,c}'
  s.resources = 'PhotoPickerPlus/Resources/**'
  s.frameworks = 'AssetsLibrary', 'CoreGraphics', 'QuartzCore', 'Photos'  
  s.dependency 'Chute-SDK','~> 2.0.7'
  s.prefix_header_contents = "#import <AFNetworking/AFNetworking.h>"

end
