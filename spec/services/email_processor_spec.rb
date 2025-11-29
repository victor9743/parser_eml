require "rails_helper"

RSpec.describe EmailProcessor do
  let(:mail_forn_a) { Mail.new(from: "loja@fornecedorA.com") }
  let(:mail_unknown) { Mail.new(from: "outro@dominio.com") }

  it "selects FornecedorAParser for fornecedorA.com" do
    parser = described_class.for(mail_forn_a)
    expect(parser).to be_a(Parsers::FornecedorAParser)
  end

  it "raises NoParserFound for unknown senders" do
    expect { described_class.for(mail_unknown) }.to raise_error(NoParserFound)
  end
end
