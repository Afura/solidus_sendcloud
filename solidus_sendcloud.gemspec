# frozen_string_literal: true

require_relative 'lib/solidus_sendcloud/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_sendcloud'
  spec.version = SolidusSendcloud::VERSION
  spec.authors = ['Victor ter Hark']
  spec.email = 'victor@afurastore.com'

  spec.summary = 'Integrate your Solidus store with SendCloud.'
  spec.description = 'Solidus SendCloud integration'
  spec.homepage = 'https://github.com/Afura/afurastore'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Afura/afurastore'
  spec.metadata['changelog_uri'] = 'https://github.com/Afura/afurastore/releases'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'solidus_core', ['>= 2.0.0', '< 5']
  spec.add_dependency 'solidus_support', '~> 0.5'
  # spec.add_dependency 'solidus_webhooks'
  spec.add_dependency 'httparty'
  spec.add_dependency 'faraday'
  
  spec.add_development_dependency 'solidus_dev_support'
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'shoulda-matchers', '~> 5.0'
  spec.add_development_dependency 'json-schema'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
end