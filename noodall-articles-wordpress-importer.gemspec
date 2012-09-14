require File.expand_path("../lib/noodall/articles/wordpress-importer/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "noodall-articles-wordpress-importer"
  s.version     = Noodall::Articles::WordPressImporter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jordan Elver"]
  s.email       = ["info@wearebeef.co.uk"]
  s.homepage    = "https://github.com/noodall/noodall-articles-wordpress-importer"
  s.summary     = "Noodall Articles WordPress Importer"
  s.description = "Import your WordPress blog into Noodall Articles"
  s.add_dependency 'sanitize'
end
