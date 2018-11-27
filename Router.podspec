
Pod::Spec.new do |s|
  s.name         = "Router"
  s.version      = "0.0.1"
  s.summary      = "Swift 路由 router"
  s.description  = <<-DESC
  Swift 版本的router：
  可通过注册的scheme 获取ViewController，也可通过native的配置获取ViewController
                   DESC

  s.homepage     = "https://github.com/KKLater/Router"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Later" => "lshxin89@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/KKLater/Router.git", :tag => s.version }
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.source_files = 'Router/*.swift'
end
