# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target '1o1 Fitness' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for 1o1 Fitness
  pod 'SwiftGifOrigin'
  pod 'KeychainAccess'
  pod 'AWSCore', '~> 2.9.0'
  pod 'AWSMobileClient', '~> 2.9.0'
  pod 'Alamofire', '4.9'
  pod 'ReachabilitySwift'
  pod 'FSCalendar'
  pod "MBCircularProgressBar"
  pod 'Cosmos', '~> 20.0'
  pod 'SDWebImage'
  pod 'GoogleSignIn'
  pod 'KYCircularProgress'
  pod 'razorpay-pod', '~> 1.1.5'
  pod 'Stripe', '~> 19.3.0'
  pod 'Parchment'
  pod 'PopupDialog', '~> 1.1'
  pod 'GooglePlaces', '~> 3.6.0'
  pod 'TwilioVideo', '~> 3.0.1'
  pod 'CropViewController'
  pod 'IQKeyboardManagerSwift'
  pod 'BarcodeScanner'
  pod 'Firebase/Auth'
  pod 'Firebase/Messaging'
  pod 'PieCharts'
  pod "youtube-ios-player-helper"

  target '1o1 FitnessTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target '1o1 FitnessUITests' do
    # Pods for testing
  end

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
