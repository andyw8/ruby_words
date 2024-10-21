# frozen_string_literal: true

require_relative "ruby_words/version"

require "rbs"

module RubyWords
  class Error < StandardError; end

  class Ruby
    def initialize
      @method_names = []
    end

    def run
      loader = RBS::EnvironmentLoader.new
      RBS::Environment.from_loader(loader).resolve_type_names

      loader.each_signature do |_source, pathname, _buffer, declarations, _directives|
        process_signature(pathname, declarations)
      end
    end

    def all
      @method_names.uniq.sort
    end

    private

    def process_signature(pathname, declarations)
      declarations.each do |declaration|
        process_declaration(declaration, pathname)
      end
    end

    def process_declaration(declaration, pathname)
      case declaration
      when RBS::AST::Declarations::Class, RBS::AST::Declarations::Module
        handle_class_or_module_declaration(declaration, pathname)
      else
        # Other kinds not yet handled
      end
    end

    def handle_class_or_module_declaration(declaration, pathname)
      declaration.members.each do |member|
        case member
        when RBS::AST::Members::MethodDefinition
          handle_method(member)
        end
      end
    end

    def handle_method(member)
      name = member.name.name
      @method_names.append(*name.split("_"))
    end
  end
end
