Pod::Spec.new do |s|
  s.name             = 'StackableTableView'
  s.version          = '0.1.0'
  s.summary          = 'UITableView with stacked views for header and footer'
  s.description      = <<-DESC
  StackableTableView utilizes UITableView's tableHeaderView, tableFooterView, and UIStackView
  to set an array of views for headers and footers.
                       DESC

  s.homepage         = 'https://github.com/omaralbeik/StackableTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Omar Albeik' => 'https://omaralbeik.com' }
  s.source           = { :git => 'https://github.com/omaralbeik/StackableTableView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/omaralbeik'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.1'

  s.source_files = "Sources/*.swift"
  s.frameworks = 'UIKit'
end