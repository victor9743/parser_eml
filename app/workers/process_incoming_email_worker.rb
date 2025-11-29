class ProcessIncomingEmailWorker
  include Sidekiq::Worker

  def perform(incoming_email_id)
    EmailProcessor.new(IncomingEmail.find(incoming_email_id)).process
  end
end