module Parsers
  # Registry for email parsers based on sender email address
  class Registry
    @mapping = {
      'loja@fornecedora.com' => Parsers::FornecedorAParser,
      'contato@parceirob.com' => Parsers::ParceiroBParser
    }.freeze

    def self.for_sender(sender_email)
      @mapping[sender_email&.downcase]
    end
  end
end
