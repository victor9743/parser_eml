class IncomingEmailsController < ApplicationController
  def new
    @incoming_email = IncomingEmail.new
  end

  def create
    @incoming_email = IncomingEmail.new(filename: params[:incoming_email][:file].original_filename, sender: nil)
    @incoming_email.file.attach(params[:incoming_email][:file])

    if @incoming_email.save
      ProcessIncomingEmailWorker.perform_async(@incoming_email.id)
      redirect_to incoming_emails_path, notice: 'Arquivo enviado e processamento em background iniciado.'
    else
      render :new
    end
  end

  def index
    @incoming_emails = IncomingEmail.order(created_at: :desc)
  end

  def show
    @incoming_email = IncomingEmail.find(params[:id])
  end

  def reprocess
    @incoming_email = IncomingEmail.find(params[:id])
    ProcessIncomingEmailWorker.perform_async(@incoming_email.id)
    redirect_to @incoming_email, notice: 'Reprocessamento enfileirado.'
  end
end
