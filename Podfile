# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

def import_pods
  pod 'Cosmos', '~> 23.0'
  pod 'Firebase/Crashlytics', '~> 7.8.0'
end

target 'AdiChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  import_pods

  target 'AdiChallenge Development' do
    import_pods
  end

  target 'AdiChallenge Staging' do
    import_pods
  end
  
  target 'AdiChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AdiChallengeUITests' do
    # Pods for testing
  end

end
