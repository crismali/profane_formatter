require "profane_formatter/version"

RSpec::Support.require_rspec_core "formatters/progress_formatter"

module ProfaneFormatter
  class Formatter < RSpec::Core::Formatters::ProgressFormatter
    include RSpec::Core::Formatters::ConsoleCodes

    RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed, :start_dump

    def example_passed(notification)
      output.print wrap(".", :success)
    end

    def example_pending(notification)
      output.print wrap("*", :pending)
    end

    def example_failed(notification)
      output.print wrap("F", :failure)
    end
  end
end
