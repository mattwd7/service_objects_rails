require File.expand_path("lib/service_objects_rails/version", __dir__)

Gem::Specification.new do |gem|
  all_files = `git ls-files`.split($/)
  test_files = all_files.grep(%r{^spec/})

  gem.name = "service_objects_rails"
  gem.version = ServiceObjectsRails::VERSION
  gem.authors = ["Matthew Dick"]
  gem.email = ["mattwd7@gmail.com"]
  gem.summary = "A lightweight, high-speed service layer for Rails apps"
  gem.description = "A lightweight, high-speed service layer for Rails apps"
  gem.homepage = "https://github.com/mattwd7/service_objects_rails"
  gem.license = "MIT"
  gem.platform = Gem::Platform::RUBY
  gem.required_ruby_version = ">= 2.5.0"

  gem.files = all_files - test_files

  gem.add_development_dependency "codecov"
  gem.add_development_dependency "dotenv"
  gem.add_development_dependency "factory_bot_rails"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rails"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rubocop-performance"
  gem.add_development_dependency "rubocop-rails"
  gem.add_development_dependency "rubocop-rspec"
  gem.add_development_dependency "rubocop"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "standard"
end
