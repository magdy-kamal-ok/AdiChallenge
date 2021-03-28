# AdiChallenge
Release notes : Xcode Version : Developed in Xcode 12.2 Swift Version: Swift 5.3 iOS Version 12.0 and above, Architecture: MVVM-C.

# functionality:
    1- ability to search for Products (name or description), and pull to refresh in case error happened.
    2- can review full product details with transition animation, can check product reviews, and ability to add new review for product.

# Testability:
    1- Unit Tests, and UITests for NetworkLayer, and AdiChallenge with Coverage (NetworkLayer: 60.3%, AdiChallenge.app: 70.1%).
    
# Environments:
    1- app support 3 environments schemes (development, staging, production).
    2- added match file for certificates, and fastlane for publishing and run tests.
    
# Frameworks:
	1- NetworkLayer: is natively built framework with ability to be extended with other ApiClientManagers(like Alamofire, or Local Cached Files Manager), 
     and support DataProvider which enable Support for Codable Responses and 2 Types of Error (Local Client Error, and Remote Error), 
     and can support Local Cached Files like json file, with dynamic retry count for requests.
  	2- FirebaseCrashlytics: for crash reporting, and used to log non fatal errors

    
# Usage:
	just download the .zip file, go to project path in Command Line print  **pod install** then open AdiChallenge.xcworkspace.
