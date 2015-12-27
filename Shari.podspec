Pod::Spec.new do |s|
  s.name             = "Shari"
  s.version          = "0.2.0"
  s.summary          = "Shari is the alternative to the library of drum roll in Swift. Inspired Etsy."

  s.homepage         = "https://github.com/nakajijapan/Shari"
  s.license          = 'MIT'
  s.author           = { "nakajijapan" => "pp.kupepo.gattyanmo@gmail.com" }
  s.source           = { :git => "https://github.com/nakajijapan/Shari.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nakajijapan'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Sources/Classes/**/*'
  s.resource_bundles = {
    'Shari' => ['Sources/Assets/*.png']
  }

end
