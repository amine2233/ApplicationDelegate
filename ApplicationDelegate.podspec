#
# Be sure to run `pod lib lint ApplicationDelegate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name        = "ApplicationDelegate"
    s.version       = "0.4.1"
    s.description      = <<-DESC
      Sort description of 'ApplicationDelegate' framework
                       DESC
    s.summary           = "Sort description of 'ApplicationDelegate' framework"
      s.homepage          = "https://github.com/amine2233/ApplicationDelegate"
      s.license           = { :type => 'MIT', :file => 'LICENSE' }
      s.author            = { 'Amine Bensalah' => 'amine.bensalah@outlook.com' }
      s.ios.deployment_target = '10.0'
      s.osx.deployment_target = '10.12'
      s.tvos.deployment_target = '10.0'
      s.watchos.deployment_target = '4.0'
      s.source            = { :git => "https://github.com/amine2233/ApplicationDelegate.git", :tag => s.version.to_s }
      s.source_files      = "Sources/**/*.swift"
      s.swift_version = '5.0'
      s.module_name = s.name

      s.exclude_files = "Sources/ApplicationDelegate/Config/*.plist"
      s.ios.exclude_files = "Sources/ApplicationDelegate/AppKit", "Sources/ApplicationDelegate/WatchKit"
      s.osx.exclude_files = "Sources/ApplicationDelegate/UIKit", "Sources/ApplicationDelegate/WatchKit"
      s.tvos.exclude_files = "Sources/ApplicationDelegate/AppKit", "Sources/ApplicationDelegate/WatchKit"
      s.watchos.exclude_files = "Sources/ApplicationDelegate/AppKit", "Sources/ApplicationDelegate/UIKit"

      # AppKit Extensions
      s.subspec 'AppKit' do |sp|
        sp.source_files  = 'Sources/ApplicationDelegate/AppKit/*.swift'
      end
      # UIKit Extensions
      s.subspec 'UIKit' do |sp|
        sp.source_files  = 'Sources/ApplicationDelegate/UIKit/*.swift'
      end
      # WatchKit Extensions
      s.subspec 'WatchKit' do |sp|
        sp.source_files  = 'Sources/ApplicationDelegate/WatchKit/*.swift'
      end
  end
