require "rails_helper"

RSpec.describe Parsers::ParceiroBParser do
    it "parses a valid email successfully to contato parceiro b" do
        mail = load_email("contato_parceiro_b_ok.eml")
        parser = described_class.new(mail)

        result = parser.call

        expect(result.success?).to eq(true)
        expect(result.customer_attrs[:name]).to eq("Fernanda Lima")
        expect(result.customer_attrs[:phone]).to eq("61 93333-4444")
    end

    it "extracts product_code from phrase format to contato parceiro b" do
        mail = load_email("contato_parceiro_b_ok.eml")
        parser = described_class.new(mail)

        result = parser.call

        expect(result.customer_attrs[:product_code]).to eq("PROD-999")
    end

    it "fails when there is no email and no phone to contato parceiro b" do
        mail = load_email("contato_parceiro_b_missing_phone.eml")
        parser = described_class.new(mail)

        result = parser.call

        expect(result.success?).to eq(false)
        expect(result.error_message).to match(/No Contact/)
    end
end