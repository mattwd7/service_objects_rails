$LOAD_PATH << File.expand_path("lib", __dir__)
require "services/version"

Gem::Specification.new do |gem|
  gem.name = "service_objects_rails"
  gem.version = Services::VERSION
  gem.authors = ["Matthew Dick"]
  gem.email = ["mattwd7@gmail.com"]
  gem.summary = "A lightweight, high-speed service layer for Rails applications"
  gem.description = "A lightweight, high-speed service layer for Rails applications"
  gem.homepage = "https://github.com/mattwd7/service_objects_rails"
  gem.license = "MIT"
  gem.platform = Gem::Platform::RUBY
  gem.required_ruby_version = ">= 2.5.0"
  gem.require_path = "lib"
  gem.files = Dir.glob("lib/**/*") + [
    "service_objects_rails.gemspec",
    "Gemfile",
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md"
  ]

  gem.add_development_dependency "codecov", "~> 0.6"
  gem.add_development_dependency "dotenv", "~> 2.7"
  gem.add_development_dependency "factory_bot_rails", "~> 6.2"
  gem.add_development_dependency "pry", "~> 0.14"
  gem.add_development_dependency "rake", "~> 13.0"
  gem.add_development_dependency "rails", "~> 7.0"
  gem.add_development_dependency "rspec-rails", "~> 5.1"
  gem.add_development_dependency "rspec", "~> 3.11"
  gem.add_development_dependency "rubocop-performance", "~> 1.13"
  gem.add_development_dependency "rubocop-rails", "~> 2.13"
  gem.add_development_dependency "rubocop-rspec", "~> 2.8"
  gem.add_development_dependency "rubocop", "~> 1.25"
  gem.add_development_dependency "simplecov", "~> 0.21"
  gem.add_development_dependency "standard", "~> 1.7"
end
