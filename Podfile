# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'

target 'Salomat' do
use_frameworks!
  # Comment the next line if you don't want to use dynamic frameworks


pod 'SkeletonView'
pod 'MultiSlider'
pod 'SnapKit'
pod 'Cosmos'
pod 'TinyConstraints'
pod 'Locksmith'
pod 'SwiftKeychainWrapper'
pod 'KeychainAccess'
pod 'Alamofire'
pod 'Kingfisher'
end

deployment_target = '11.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end

