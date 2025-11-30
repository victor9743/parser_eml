# app/workers/process_incoming_email_worker.rb
class ProcessIncomingEmailWorker
  include Sidekiq::Worker

  def perform(incoming_email_id)
    EmailProcessor.new(IncomingEmail.find(incoming_email_id)).process
  end
end
