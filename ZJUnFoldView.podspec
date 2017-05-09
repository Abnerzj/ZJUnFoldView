Pod::Spec.new do |s|
  s.name         = "ZJUnFoldView"
  s.version      = "1.0.0"
  s.summary      = "A fast, convenient view to unfold or fold content details."
  s.description  = <<-DESC
    A fast, convenient view to unfold or fold content details, even you only need to pass in a text content.
                    DESC
  s.homepage     = "https://github.com/Abnerzj/ZJUnFoldView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Abnerzj" => "Abnerzj@163.com" }
  s.social_media_url   = "http://weibo.com/ioszj"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Abnerzj/ZJUnFoldView.git", :tag => "#{s.version}" }
  s.source_files  = "ZJUnFoldView/ZJUnFoldView/*.{h,m}"
  s.requires_arc = true
end
