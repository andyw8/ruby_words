# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Ruby gem that extracts words from the Ruby language by parsing RBS type signatures. It uses the `rbs` gem to load Ruby's standard library type definitions and extracts method names, splitting them by underscores to create a word list suitable for programming dictionaries (e.g., cspell).

## Key Commands

### Setup
- `bin/setup` - Install dependencies and prepare the development environment

### Testing
- `rake test` - Run the test suite (using Minitest)
- `rake` - Run default task (tests + linting)

### Linting
- `rake standard` - Run Standard Ruby linter (auto-formatter based on RuboCop)
- `bundle exec standardrb --fix` - Auto-fix linting issues

### Running the Tool
- `bundle exec exe/ruby_words` - Run the CLI locally (outputs a sorted list of words to stdout)
- `bin/console` - Start an interactive console for experimentation

### Gem Management
- `bundle exec rake install` - Install gem locally for testing
- `bundle exec rake release` - Release a new version (tags, pushes to RubyGems)

## Architecture

### Core Implementation (`lib/ruby_words.rb`)

The main logic is in the `RubyWords::Ruby` class:

1. **RBS Loading**: Uses `RBS::EnvironmentLoader` to load all RBS type signatures from Ruby's standard library
2. **AST Traversal**: Walks through RBS declarations, focusing on class/module declarations
3. **Method Extraction**: Extracts method names from method definitions
4. **Word Splitting**: Splits method names by underscores to create individual words (e.g., `to_s` becomes `["to", "s"]`)
5. **Deduplication**: Returns unique, sorted word list

### Executable (`exe/ruby_words`)

Simple CLI that instantiates `RubyWords::Ruby`, calls `run` to process all signatures, and outputs the word list.

## Code Style

- Uses **Standard Ruby** for code formatting and linting (extends RuboCop)
- Enforces **double quotes** for string literals (see `.rubocop.yml`)
- Requires Ruby >= 3.0
- Uses `frozen_string_literal: true` in all Ruby files

## Testing

- Uses **Minitest** as the testing framework
- Test files located in `test/`
- Currently minimal test coverage (only version check)

## Type Signatures

- RBS type signatures are in `sig/` directory
- Main signature file: `sig/ruby_words.rbs`
- The gem itself depends on the `rbs` gem (~> 3.6)
