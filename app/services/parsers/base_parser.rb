module Parsers
  class BaseParser
    Result = Struct.new(:success?, :customer_attrs, :error_message) do
      def to_h
        { success: success?, customer_attrs: customer_attrs, error_message: error_message }
      end
    end

    def initialize(raw_mail)
      @mail = Mail.read_from_string(raw_mail.is_a?(String) ? raw_mail : raw_mail.read)
    end

    def call
      raise NotImplementedError
    end

    protected

    def extract_name(...)
    end
    
  end
end