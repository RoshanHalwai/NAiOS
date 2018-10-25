# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

def shared_pods
    # Pods for nammaApartment
    pod 'HCSStarRatingView', '~> 1.5'
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase'
    pod 'Firebase/Auth'
    pod 'Firebase/Storage'
    pod 'Firebase/Messaging'
    pod 'FirebaseUI/Phone'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'razorpay-pod', '1.0.18'
    pod 'GoogleToolboxForMac', '~> 2.1'
    pod 'SDWebImage'
end

target 'nammaApartment' do
    shared_pods
    target 'nammaApartmentTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'nammaApartmentUITests' do
        inherit! :search_paths
        # Pods for testing
    end
end

target 'nammaApartmentBETA' do
    shared_pods
end
