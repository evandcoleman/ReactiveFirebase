Pod::Spec.new do |s|
  s.name = 'ReactiveFirebase'
  s.version = '0.1.3'
  s.summary = 'ReactiveSwift extensions for Firebase.'

  s.homepage = 'https://github.com/edc1591/ReactiveFirebase'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Evan Coleman' => 'e@edc.me' }
  s.source = { :git => 'https://github.com/edc1591/ReactiveFirebase.git', :tag => "v#{s.version.to_s}" }
  s.social_media_url = 'https://twitter.com/edc1591'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ReactiveFirebase/**/*'
  s.dependency 'ReactiveCocoa', '5.0.0.alpha.6'
  s.dependency 'ReactiveSwift', '1.0.0-rc.3'

  s.dependency 'Firebase/Auth', '~> 3.11.0'
  s.dependency 'Firebase/Database', '~> 3.11.0'
  s.dependency 'Firebase/Storage', '~> 3.11.0'

  s.libraries = 'stdc++'
  s.frameworks = 'FirebaseCore', 'FirebaseDatabase', 'FirebaseAnalytics', 'FirebaseAuth', 'FirebaseStorage', 'GoogleSymbolUtilities', 'GoogleInterchangeUtilities'
  
  frameworks = [
    '$(PODS_ROOT)/FirebaseCore/Frameworks',
    '$(PODS_ROOT)/FirebaseCore/Frameworks/frameworks',
    '$(PODS_ROOT)/FirebaseDatabase/Frameworks',
    '$(PODS_ROOT)/FirebaseDatabase/Frameworks/frameworks',
    '$(PODS_ROOT)/FirebaseAnalytics/Frameworks',
    '$(PODS_ROOT)/FirebaseAnalytics/Frameworks/frameworks',
    '$(PODS_ROOT)/FirebaseAuth/Frameworks',
    '$(PODS_ROOT)/FirebaseAuth/Frameworks/frameworks',
    '$(PODS_ROOT)/FirebaseStorage/Frameworks',
    '$(PODS_ROOT)/FirebaseStorage/Frameworks/frameworks',
    '$(PODS_ROOT)/GoogleSymbolUtilities/Frameworks',
    '$(PODS_ROOT)/GoogleSymbolUtilities/Frameworks/frameworks',
    '$(PODS_ROOT)/GoogleInterchangeUtilities/Frameworks',
    '$(PODS_ROOT)/GoogleInterchangeUtilities/Frameworks/frameworks',
  ]

  s.pod_target_xcconfig = {
    "FRAMEWORK_SEARCH_PATHS" => frameworks.join(" "),
  }
end
