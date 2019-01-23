#
# Be sure to run `pod lib lint MatchTransition.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'MatchTransition'
  s.version               = '1.2.0'
  s.summary               = 'A quick and easy way to create beautiful Modal Transitions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description           = <<-DESC
'This pod allows you to easily create a beautiful transition between a UICollectionViewCell or a UITableViewCell and a DetailsViewController. It matches views between the cell and the arriving UIViewController using tags, it then creates a transition between the two.'
                          DESC

  s.homepage              = 'https://github.com/LorTos/MatchTransition'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'LorTos' => 'lorenzotoscanidc@gmail.com' }
  s.source                = { :git => 'https://github.com/LorTos/MatchTransition.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version         = '4.2'

  s.source_files          = 'MatchTransition/Classes/**/*', 'MatchTransition/Classes/*'
  s.frameworks            = 'UIKit'
end
