require "rails_helper"

RSpec.describe Parsers::BaseParser do
  let(:raw_mail) { "From: test@example.com\n\nTeste" }

  it "raises NotImplementedError if call is not implemented" do
    parser = described_class.new(raw_mail)
    expect { parser.call }.to raise_error(NotImplementedError)
  end

  it "stores mail instance" do
    parser = described_class.new(raw_mail)
    expect(parser.instance_variable_get(:@mail).from).to include("test@example.com")
  end
end
