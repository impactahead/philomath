lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'philomath/version'

Gem::Specification.new do |s|
  s.add_development_dependency 'pry'
  s.add_runtime_dependency 'markdownlyze', '= 0.0.2'
  s.add_runtime_dependency 'prawn_components', '= 0.0.1'
  s.add_runtime_dependency 'prawn', '>= 2.2.2'
  s.add_runtime_dependency 'nokogiri', '= 1.16.7'
  s.name        = 'philomath'
  s.version     = Philomath::Version
  s.date        = '2024-11-17'
  s.summary     = "Turn markdown files into PDF book"
  s.description = "Turn markdown files into PDF book"
  s.authors     = ["Paweł Dąbrowski"]
  s.email       = 'contact@paweldabrowski.com'
  s.files       = Dir['lib/**/*.rb']
end
