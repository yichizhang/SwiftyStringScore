#
# Be sure to run `pod lib lint StringScore_Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "StringScore_Swift"
  s.version          = "0.1.1"
  s.summary          = "Swift string search and fuzzy ranking. Score of 0 for no match; up to 1 for perfect."
  s.description      = "Swift string search and fuzzy ranking. Score of 0 for no match; up to 1 for perfect. StringScore_Swift is a Swift library which provides fast fuzzy string matching/scoring. Based on the JavaScript library of the same name, by Joshaven Potter."
  s.homepage         = "https://github.com/yichizhang/StringScore_Swift"
  s.license          = 'MIT'
  s.author           = { "Yichi Zhang" => "zhang-yi-chi@hotmail.com" }
  s.source           = { :git => "https://github.com/yichizhang/StringScore_Swift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nsyichi'
  s.requires_arc = true
  s.source_files = 'Source/**/*'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
end
