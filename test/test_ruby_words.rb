# frozen_string_literal: true

require "test_helper"

class TestRubyWords < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyWords::VERSION
  end

  def test_extracts_common_ruby_words
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify some common words from Ruby method names are present
    assert_includes words, "add"
    assert_includes words, "all"
    assert_includes words, "get"
    assert_includes words, "new"
    assert_includes words, "to"
  end

  def test_excludes_punctuation_only_entries
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify no punctuation-only entries (operators like +, -, <<, etc.)
    punctuation_only = words.select { |word| !word.match?(/[a-zA-Z0-9]/) }
    assert_empty punctuation_only, "Found punctuation-only entries: #{punctuation_only.inspect}"
  end

  def test_strips_question_and_exclamation_suffixes
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify no words end with ?, !, or =
    with_suffixes = words.select { |word| word.end_with?("?", "!", "=") }
    assert_empty with_suffixes, "Found words with ?, !, or = suffixes: #{with_suffixes.inspect}"

    # Verify base words from methods like empty?, nil?, capitalize! are present
    assert_includes words, "empty"
    assert_includes words, "nil"
  end

  def test_excludes_single_letter_words
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify no single letter words
    single_letters = words.select { |word| word.length == 1 }
    assert_empty single_letters, "Found single letter words: #{single_letters.inspect}"
  end

  def test_includes_class_names
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify common Ruby class names are included
    assert_includes words, "Array"
    assert_includes words, "String"
    assert_includes words, "Hash"
    assert_includes words, "Integer"
  end

  def test_splits_namespaced_classes
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify namespaced classes are split (e.g., Encoding::Converter)
    assert_includes words, "Encoding"
    assert_includes words, "Converter"

    # Verify no :: remains in any word
    with_colons = words.select { |word| word.include?("::") }
    assert_empty with_colons, "Found words with :: : #{with_colons.inspect}"
  end

  def test_splits_camel_case
    ruby_words = RubyWords::Ruby.new
    ruby_words.run
    words = ruby_words.all

    # Verify CamelCase class names are split
    # EOFError -> EOF, Error
    assert_includes words, "EOF"
    assert_includes words, "Error"

    # ArgumentError -> Argument, Error
    assert_includes words, "Argument"

    # FileTest -> File, Test
    assert_includes words, "File"
    assert_includes words, "Test"
  end
end
