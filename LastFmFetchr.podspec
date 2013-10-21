Pod::Spec.new do |s|
  s.name         = "LastFmFetchr"
  s.version      = "0.0.1"
  s.summary      = "A lightweight JSON-based Objective-C wrapper to make asynchronous requests for the Last.fm API."
  s.homepage     = "https://github.com/simontea/LastFmFetchr"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Simon Tännler'
  s.source       = { :git => "https://github.com/simontea/LastFmFetchr.git", :tag => "v0.0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'LastFmFetchr/*'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 2.0'
  s.dependency 'KZPropertyMapper', '~> 2.0'
  s.dependency 'FCYAsserts', '~> 1.2'
end
