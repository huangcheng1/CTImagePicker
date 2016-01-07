#
# Be sure to run `pod lib lint CTImagePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CTImagePicker"
  s.version          = "0.1.0"
  s.summary          = " CTImagePicker."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
照片选择器
                       DESC

  s.homepage         = "https://github.com/Mikora/CTImagePicker"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "黄成" => "632300630@qq.com" }
  s.source           = { :git => "https://github.com/Mikora/CTImagePicker.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CTImagePicker' => ['Pod/Assets/loc/**/*','Pod/Assets/images/**/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit' , 'AssetsLibrary'
  # s.dependency 'AFNetworking', '~> 2.3'
end
