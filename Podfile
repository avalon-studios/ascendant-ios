platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

target 'Ascendant' do
    pod 'Socket.IO-Client-Swift'
    pod 'R.swift'
    pod 'Gloss'
    pod 'PureLayout'
    pod 'ElegantPresentations'
    pod 'AsyncSwift'
    pod 'Fabric'
    pod 'Crashlytics'
end

target 'AscendantTests' do

end

target 'AscendantUITests' do

end

post_install do |installer|
    
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-Ascendant/Pods-Ascendant-acknowledgements.plist', 'Ascendant/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
    
    # bitrise codesigning fix
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end
