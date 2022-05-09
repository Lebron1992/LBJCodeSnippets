Pod::Spec.new do |s|

  s.platform     = :ios, "11.0"
  s.name         = "LBJCodeSnippets"
  s.summary      = "LBJCodeSnippets."
  s.requires_arc = true

  s.version      = "0.0.1"

  s.homepage     = "https://github.com/Lebron1992/LBJCodeSnippets"

  s.license      = { :type => "MIT" }

  s.author       = { "Lebron" => "wenzhi.zeng@outook.com" }

  s.source       = { :git => "https://github.com/Lebron1992/LBJCodeSnippets.git", :tag => "#{s.version}" }

  s.source_files = "Sources/LBJCodeSnippets/**/*.{swift}"

end
