module Parsers
  class BaseParser
    Result = Struct.new(:success?, :customer_attrs, :error_message) do
      def to_h
        { success: success?, customer_attrs: customer_attrs, error_message: error_message }
      end
    end

    def initialize(raw_mail_or_mail_object)
      # Se já for um objeto Mail, usa ele.
      if raw_mail_or_mail_object.is_a?(Mail::Message)
        @mail = raw_mail_or_mail_object
      else
        # Lógica de conversão de conteúdo bruto para objeto Mail (o que você já tem)
        mail_content = if raw_mail_or_mail_object.is_a?(String)
                        raw_mail_or_mail_object
                      elsif raw_mail_or_mail_object.respond_to?(:download)
                        raw_mail_or_mail_object.download
                      elsif raw_mail_or_mail_object.respond_to?(:read)
                        raw_mail_or_mail_object.read
                      else
                        raise ArgumentError, "Argumento inválido."
                      end
                          
        @mail = Mail.read_from_string(mail_content)
      end
    end
    

    def call
      raise NotImplementedError
    end

    protected

    def extract_name(...)
    end
    
  end
end