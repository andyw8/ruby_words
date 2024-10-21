# frozen_string_literal: true

require_relative "ruby_words/version"

module RubyWords
  class Error < StandardError; end
  class << self
    def all
      []
    end
  end
end
