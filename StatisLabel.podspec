#
# Be sure to run `pod lib lint StatisLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StatisLabel"
  s.version          = "0.1.0"
  s.summary          = "StatisLabel short description of "

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      ="this is just cocoaTest ap cocoaTest adasdas arben pnishi p9"

  s.homepage         = "https://github.com/esatp/StatisLabel"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Esat Pllana" => "esatpllana@appsix.al" }
  s.source           = { :git => "https://github.com/esatp/StatisLabel.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/eskopium'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'StatisLabel' => ['Pod/Assets/*.{h,m,xib,png}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
