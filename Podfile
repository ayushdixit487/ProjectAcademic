# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Acadmic' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Acadmic
    pod 'ENSwiftSideMenu'
    pod 'IQKeyboardManagerSwift'
    pod 'Cosmos', '~> 16.0'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'YYWebImage'
    pod "CTKFlagPhoneNumber"
    pod 'Firebase'
    pod 'Firebase/Auth'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'

     post_install do |installer|
        installer.pods_project.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
end
