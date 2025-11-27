# app/services/parsers/fornecedor_a_parser.rb
module Parsers
  class FornecedorAParser < BaseParser
    def call
      body = @mail.body.decoded
      # logic of regex/templating to extract: name, email, phone, product_code, subject
      name = body[/Nome:\s*(.+)/,1]&.strip
      email = body[/E-mail:\s*(\S+)/,1]&.strip
      phone = body[/Telefone:\s*(.+)/,1]&.strip
      product_code = body[/Produto:\s*(\w+)/,1]&.strip
      subject = @mail.subject

      if email.blank? && phone.blank?
        return Result.new(false, {}, "No Contact (email/phone) found")
      end

      customer_attrs = { name: name, email: email, phone: phone, product_code: product_code, subject: subject }
      Result.new(true, customer_attrs, nil)
    rescue => e
      Result.new(false, {}, e.message)
    end
  end
end
