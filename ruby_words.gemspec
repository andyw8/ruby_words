# frozen_string_literal: true

require_relative "lib/ruby_words/version"

Gem::Specification.new do |spec|
  spec.name = "ruby_words"
  spec.version = RubyWords::VERSION
  spec.authors = ["Andy Waite"]
  spec.email = ["13400+andyw8@users.noreply.github.com"]

  spec.summary = "A list of words from the Ruby programming language"
  spec.homepage = "https://github.com/andyw8/ruby_words"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andyw8/ruby_words"
  spec.metadata["changelog_uri"] = "https://github.com/andyw8/ruby-lsp/releases"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rbs", "~> 3.6"
end
