# frozen_string_literal: true

require_relative "lib/rick_and_morty_dub_dub/version"

Gem::Specification.new do |spec|
  spec.name = "rick_and_morty_dub_dub"
  spec.version = RickAndMortyDubDub::VERSION
  spec.authors = ["Jonathan de Oliveira Silva"]
  spec.email = ["jonathanoliveirasilva9@gmail.com"]

  spec.summary = %q(Use this gem to integrate with RickAndMorty API)
  spec.description = %q(This gem implements support to integrate with RickAndMorty API)
  spec.homepage = 'https://github.com/jonathanoliveira9/rick_and_morty_dub_dub'
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = 'https://github.com/jonathanoliveira9/rick_and_morty_dub_dub'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/jonathanoliveira9/rick_and_morty_dub_dub'
  spec.metadata["changelog_uri"] = 'https://github.com/jonathanoliveira9/rick_and_morty_dub_dub'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "factory_bot"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
