Pod::Spec.new do |s|
  s.name = 'ReactiveFirebase'
  s.version = '0.1.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'ReactiveSwift extensions for Firebase.'
  s.homepage = 'https://github.com/edc1591/ReactiveFirebase'
  s.authors = { 'Evan Coleman' => 'oss@edc.me' }
  s.source = { :http => 'https://github.com/edc1591/ReactiveFirebase/releases/download/v0.1.0/ReactiveFirebaseFrameworks.zip' }
  
  s.ios.deployment_target = "8.0"
  s.dependency 'ReactiveCocoa', '5.0.0.alpha.3'
  s.dependency 'ReactiveSwift', '1.0.0.alpha.4'
  s.default_subspecs = 'All'

  s.subspec 'All' do |ss|
    ss.dependency 'ReactiveFirebase/Auth'
    ss.dependency 'ReactiveFirebase/Database'
    ss.dependency 'ReactiveFirebase/Storage'
  end

  s.subspec 'Auth' do |ss|
    ss.vendored_frameworks = ["ReactiveFirebaseFrameworks/ReactiveFirebaseAuth/Frameworks/ReactiveFirebaseAuth.framework"]
    ss.dependency 'Firebase/Auth', '3.11.0'
  end

  s.subspec 'Database' do |ss|
    ss.vendored_frameworks = ["ReactiveFirebaseFrameworks/ReactiveFirebaseDatabase/Frameworks/ReactiveFirebaseDatabase.framework"]
    ss.dependency 'Firebase/Database', '3.11.0'
  end

  s.subspec 'Storage' do |ss|
    ss.vendored_frameworks = ["ReactiveFirebaseFrameworks/ReactiveFirebaseStorage/Frameworks/ReactiveFirebaseStorage.framework"]
    ss.dependency 'Firebase/Storage', '3.11.0'
  end
end
