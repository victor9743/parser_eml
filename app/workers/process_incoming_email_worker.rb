class ProcessIncomingEmailWorker
  include Sidekiq::Worker

  def perform(incoming_email_id)
    incoming = IncomingEmail.find(incoming_email_id)
    EmailProcessor.new(incoming).process
  end
end