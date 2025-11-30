# app/services/parsers/fornecedor_a_parser.rb
module Parsers
  # Parser for emails from Fornecedor A
  class FornecedorAParser < BaseParser
    def call
      body = extract_body

      customer_attrs = extract_customer_attributes(body)
      return Result.new(false, {}, 'No Contact (email/phone) found') if invalid_contact?(customer_attrs)

      Result.new(true, customer_attrs, nil)
    rescue StandardError => e
      Result.new(false, {}, e.message)
    end

    private

    def extract_body
      @mail.body.decoded.scrub.force_encoding('UTF-8')
    end

    def extract_customer_attributes(body)
      {
        name: extract_name(body),
        email: extract_email(body),
        phone: extract_phone(body),
        product_code: extract_product_code(body),
        subject: @mail.subject
      }
    end

    def extract_name(body)
      body[/^Nome(?: do cliente)?:\s*(.*?)\r?$/i, 1]&.strip
    end

    def extract_email(body)
      body[/^E-mail:\s*(\S+)\r?$/i, 1]&.strip
    end

    def extract_phone(body)
      body[/^Telefone:\s*(.*?)\r?$/i, 1]&.strip.presence
    end

    def extract_product_code(body)
      code = body[/^(?:Produto|Código|Produto de código):\s*(.*?)\r?$/i, 1] ||
             body[/produto de código\s+(\w+)/i, 1]
      code&.strip
    end

    def invalid_contact?(customer_attrs)
      customer_attrs[:email].blank? && customer_attrs[:phone].blank?
    end
  end
end
