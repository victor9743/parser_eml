module Parsers
  class Registry
    @mapping = {
      'fornecedorA@gmail.com' => Parsers::FornecedorAParser,
      'parceiroB@gmail.org' => Parsers::ParceiroBParser
    }.freeze

    def self.for_sender(sender_email)
      @mapping[sender_email&.downcase]
    end

    # allow dynamic register
    def self.register(sender, klass)
      @mapping[sender.downcase] = klass
    end
  end
end
