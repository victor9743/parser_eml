# app/services/email_processor.rb
class EmailProcessor
  def initialize(incoming_email)
    @incoming_email = incoming_email
    @raw = load_raw_email
  end

  def process
    @incoming_email.update!(status: 'processing')
    parser_class = Parsers::Registry.for_sender(sender_email)
    raise "No parser for sender #{sender_email}" unless parser_class

    parser = parser_class.new(@raw)
    result = parser.call

    if result.success?
      ActiveRecord::Base.transaction do
        customer = Customer.create!(result.customer_attrs)
        @incoming_email.email_processings.create!(success: true, extracted_data: result.to_h)
        @incoming_email.update!(status: 'success')
      end
    else
      @incoming_email.email_processings.create!(success: false, error_message: result.error_message, extracted_data: result.to_h)
      @incoming_email.update!(status: 'failed')
    end
  rescue => e
    @incoming_email.email_processings.create!(success: false, error_message: e.message)
    @incoming_email.update!(status: 'failed')
    raise
  end

  private

  def load_raw_email
    # read attachment ActiveStorage
    StringIO.new(@incoming_email.file.download)
  end

  def sender_email
    mail = Mail.read_from_string(load_raw_email.read)
    mail.from&.first&.downcase
  end
end
