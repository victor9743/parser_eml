module Parsers
  # Base parser class
  class BaseParser
    Result = Struct.new(:success?, :customer_attrs, :error_message) do
      def to_h
        { success: success?, customer_attrs: customer_attrs, error_message: error_message }
      end
    end

    def initialize(raw_mail_or_mail_object)
      # If it's already a Mail object, use that.
      if raw_mail_or_mail_object.is_a?(Mail::Message)
        @mail = raw_mail_or_mail_object
      else
        # Logic for converting raw content to a Mail object (which you already have).
        mail_content = if raw_mail_or_mail_object.is_a?(String)
                         raw_mail_or_mail_object
                       elsif raw_mail_or_mail_object.respond_to?(:download)
                         raw_mail_or_mail_object.download
                       elsif raw_mail_or_mail_object.respond_to?(:read)
                         raw_mail_or_mail_object.read
                       else
                         raise ArgumentError, 'Argumento inválido.'
                       end

        @mail = Mail.read_from_string(mail_content)
      end
    end

    def call
      raise NotImplementedError
    end

    protected

    def extract_name(...); end
  end
end
