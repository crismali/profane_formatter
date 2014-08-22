require "profane_formatter/version"

RSpec::Support.require_rspec_core "formatters/progress_formatter"

module ProfaneFormatter
  class ProfanityFormatter < RSpec::Core::Formatters::ProgressFormatter
    include RSpec::Core::Formatters::ConsoleCodes

    RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed, :start_dump

    attr_accessor :failure_counter

    def initialize(*args, &block)
      super
      self.failure_counter = 0
    end

    def example_passed(notification)
      print_profanity
      output.print wrap(".", :success)
    end

    def example_pending(notification)
      print_profanity
      output.print wrap("*", :pending)
    end

    def example_failed(notification)
      output.print wrap("F", :failure)
      self.failure_counter += 1
    end

    private

    def print_profanity
      profanity = ("U" * failure_counter) + "CK"
      output.print wrap(profanity, :failure) unless failure_counter.zero?
      self.failure_counter = 0
    end
  end
end
