Pod::Spec.new do |s|
  s.name         = "CocoaHTTPServer-Routing"
  s.version      = "1.0.1"
  s.summary      = "Adds routing to CocoaHTTPServer: you implement handler blocks that are bound to URL-Expressions that can contain wildcards like in rails."

  s.homepage     = "http://github.com/chbeer/CocoaHTTPServer-Routing"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "Christian Beer" => "christian.beer@chbeer.de" }
  s.social_media_url = "http://twitter.com/christian_beer"

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'

  s.source       = { :git => "https://github.com/chbeer/CocoaHTTPServer-Routing.git", :tag => s.version }

  s.source_files  = 'Clases/*.{h,m}'
  s.public_header_files = 'Clases/*.h'

  s.requires_arc = true

  s.dependency 'CocoaHTTPServer', '~> 2.3'

end
