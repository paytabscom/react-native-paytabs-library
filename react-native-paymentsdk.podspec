require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-paymentsdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-paymentsdk
                   DESC
  s.homepage     = "https://github.com/github_account/react-native-paymentsdk"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/github_account/react-native-paymentsdk.git", :tag => "#{s.version}" }
  s.frameworks = 'Foundation', 'CoreTelephony', 'WebKit', 'PassKit', 'SystemConfiguration', 'CoreLocation'
  s.source_files = "ios/**/*.{h,c,m,swift}"
  s.requires_arc = true
  s.swift_version = '5.0'
  s.dependency "React"
  s.dependency "PayTabsSDK", '6.3.1'
end

