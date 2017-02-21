target 'AikatsuLyric' do
  use_frameworks!

  # Pods for AikatsuLyric
  pod 'SwiftyJSON', '~> 3.0.0'
  pod 'Kingfisher', '~> 3.0'
  pod 'SwiftLint'
  pod 'ObjectMapper'
  pod 'SCLAlertView'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
