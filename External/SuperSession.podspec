#
#  Be sure to run `pod spec lint SuperSession.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name             = "SuperSession"
  s.version          = "0.0.1"
  s.summary          = "SuperSession stubs URLSession"
  s.homepage         = "https://github.com/harmeetsingh/SuperSession"
  s.license          = 'MIT'
  s.author           = { "Harmeet Singh" => "singh_120@hotmail.co.uk" }
  s.source           = { :git => "git@github.com:harmeetsingh/SuperSession.git", :tag => s.version.to_s }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = "SuperSession/Sources/**/*"
  s.frameworks = 'UIKit'

end


