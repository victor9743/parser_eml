require "rails_helper"

RSpec.describe Parsers::FornecedorAParser do
  def load_email(file)
    Mail.read(Rails.root.join("spec/fixtures/files/#{file}"))
  end

  it "parses a valid email successfully to fornecedor a" do
    mail = load_email("fornecedor_a_ok.eml")
    parser = described_class.new(mail)

    result = parser.call

    expect(result.success?).to eq(true)
    expect(result.customer_attrs[:name]).to eq("João da Silva")
    expect(result.customer_attrs[:email]).to eq("joao.silva@example.com")
    expect(result.customer_attrs[:phone]).to eq("(11) 91234-5678")
  end

  it "extracts product_code from phrase format to fornecedor a" do
    mail = load_email("fornecedor_a_ok.eml")
    parser = described_class.new(mail)

    result = parser.call

    expect(result.customer_attrs[:product_code]).to eq("ABC123")
  end

  it "fails when there is no email and no phone to fornecedor a" do
    mail = load_email("fornecedor_a_missing_phone.eml")
    parser = described_class.new(mail)

    result = parser.call

    expect(result.success?).to eq(false)
    expect(result.error_message).to match(/No Contact/)
  end
end
