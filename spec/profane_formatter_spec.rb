require "spec_helper"

RSpec.describe ProfaneFormatter::ProfanityFormatter do
  include FormatterSupport

  before do
    send_notification :start, start_notification(2)
    allow(formatter).to receive(:color_enabled?).and_return(false)
  end

  context "attr_accessor" do
    it "responds to getter" do
      expect(formatter).to respond_to(:failure_counter)
    end

    it "responds to setter" do
      expect(formatter).to respond_to(:failure_counter=)
    end
  end

  describe "#initialize" do
    it "sets failure_counter to 0" do
      expect(formatter.failure_counter).to eq(0)
    end
  end

  describe "#example_passed" do
    it "prints a . on example_passed" do
      send_notification :example_passed, example_notification
      expect(output.string).to eq(".")
    end

    it "prints out the same amount 'U's as the failure counter followed by 'CK'" do
      formatter.failure_counter = 4
      send_notification :example_passed, example_notification
      expect(output.string).to eq("UUUUCK.")
    end

    it "sets the failure_counter to 0" do
      formatter.failure_counter = 44
      send_notification :example_passed, example_notification
      expect(formatter.failure_counter).to eq(0)
    end
  end


  describe "#example_pending" do
    it "prints a * on example_pending" do
      send_notification :example_pending, example_notification
      expect(output.string).to eq("*")
    end

    it "prints out the same amount 'U's as the failure counter followed by 'CK'" do
      formatter.failure_counter = 4
      send_notification :example_pending, example_notification
      expect(output.string).to eq("UUUUCK*")
    end

    it "sets the failure_counter to 0" do
      formatter.failure_counter = 44
      send_notification :example_pending, example_notification
      expect(formatter.failure_counter).to eq(0)
    end
  end

  describe "#example_failed" do
    it "prints a F on example_failed" do
      send_notification :example_failed, example_notification
      expect(output.string).to eq("F")
    end

    it "increments the failure counter" do
      send_notification :example_failed, example_notification
      expect(formatter.failure_counter).to eq(1)
      send_notification :example_failed, example_notification
      expect(formatter.failure_counter).to eq(2)
    end
  end

  it "produces standard summary without pending when pending has a 0 count" do
    send_notification :dump_summary, summary_notification(0.00001, examples(2), [], [], 0)
    expect(output.string).to match(/^\n/)
    expect(output.string).to match(/2 examples, 0 failures/i)
    expect(output.string).not_to match(/0 pending/i)
  end

  it "pushes nothing on start" do
    # start already sent
    expect(output.string).to eq("")
  end

  describe "#start_dump" do
    it "pushes nothing on start dump" do
      send_notification :start_dump, null_notification
      expect(output.string).to eq("\n")
    end

    it "prints out the same amount 'U's as the failure counter followed by 'CK'" do
      formatter.failure_counter = 4
      send_notification :start_dump, example_notification
      expect(output.string).to eq("UUUUCK\n")
    end

    it "sets the failure_counter to 0" do
      formatter.failure_counter = 44
      send_notification :start_dump, example_notification
      expect(formatter.failure_counter).to eq(0)
    end
  end

  # The backrace is slightly different on JRuby so we skip there.
  it "produces the expected full output", :unless => RUBY_PLATFORM == "java" do
    output = run_example_specs_with_formatter("ProfaneFormatter::ProfanityFormatter")
    output.gsub!(/ +$/, "") # strip trailing whitespace

    expect(output).to eq(<<-EOS.gsub(/^\s+\|/, ""))
      |**FUCK.FFFUUUCK
      |
      |#{expected_summary_output_for_example_specs}
    EOS
  end
end
