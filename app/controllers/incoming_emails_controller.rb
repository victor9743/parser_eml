# Controller for managing incoming emails
class IncomingEmailsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :missing_file

  def index
    @incoming_emails = IncomingEmail.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @incoming_email = IncomingEmail.find(params[:id])
  end

  def new
    @incoming_email = IncomingEmail.new
  end

  def create
    @incoming_email = IncomingEmail.new(incoming_email_params)

    if @incoming_email.save
      ProcessIncomingEmailWorker.perform_async(@incoming_email.id)
      redirect_to incoming_emails_path, notice: t('.file_sent')
    else
      render :new
    end
  end

  private

  def incoming_email_params
    params.require(:incoming_email).permit(:file)
  end

  def missing_file
    flash[:alert] = t('.file_required')
    redirect_back_or_to(incoming_emails_path)
  end
end
