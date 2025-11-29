# app/services/parsers/fornecedor_a_parser.rb
module Parsers
  class ParceiroBParser < BaseParser
    def call
      body = @mail.body.decoded.scrub.force_encoding("UTF-8")

      name  = body[/^Nome(?: do cliente)?:\s*(.*?)\r?$/i, 1]&.strip
      email = body[/^E-mail:\s*(\S+)\r?$/i, 1]&.strip
      phone = body[/^Telefone:\s*(.*?)\r?$/i, 1]&.strip

      # --- Produto ---
      # 1) search code
      product_code = body[/^(?:Produto|Código|Produto de código):\s*(.*?)\r?$/i, 1]

      # 2) if 1th not not found
      product_code ||= body[/produto de código\s+(\w+)/i, 1]

      product_code&.strip!

      subject = @mail.subject

      if email.blank? && phone.blank?
        return Result.new(false, {}, "No Contact (email/phone) found")
      end

      customer_attrs = {
        name: name,
        email: email,
        phone: phone.presence,
        product_code: product_code,
        subject: subject
      }

      Result.new(true, customer_attrs, nil)
    rescue => e
      Result.new(false, {}, e.message)
    end
  end
end
