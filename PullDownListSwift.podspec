#
#  Be sure to run `pod spec lint PullDownListSwift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "PageTitleControl"
  spec.version      = "1.0.0"
  spec.swift_version      = "5.0"
  spec.summary      = "PageTitleControl 提供多标题和页面联动"
  spec.description  = <<-DESC
                            PageTitleControl 是一个添加滚动标题和页面联动的控件，也可单独添加标题滑动，单独多页面滑动
                        DESC
  spec.homepage     = "https://github.com/CMlinksuccess/PageTitleControl"
  spec.license      = 'MIT'
  spec.author       = { "xiaowanjia" => "myemil0@163.com" }
  spec.source       = { :git => "https://github.com/CMlinksuccess/PageTitleControl.git", :tag => spec.version }
  spec.platform     = :ios, '13.0'
  spec.requires_arc = true
  
  spec.resource  = 'PullDownListSwift/PullDownListSwift/pullDownListSwift.bundle'
  spec.source_files  = 'PageTitleControl/PageTitleControl/*.{swift,h}'
  spec.frameworks = 'UIKit'
  
end
