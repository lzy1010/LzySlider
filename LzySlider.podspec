Pod::Spec.new do |s|

  s.name         = "LzySlider"
  s.version      = "0.0.1"
  s.summary      = "Custom UISlider."

  s.homepage     = "https://github.com/lzy1010"

  s.license      = "MIT"

  s.author       = { "Blue" => "lzy663869@163.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/lzy1010/LzySlider" }

  s.source_files  = "LzySlider/LzySlider/LzySlider/*.{h,m}"

  s.framework = 'UIKit'

end
