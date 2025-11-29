class IncomingEmailsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :missing_file

  def index
    @incoming_emails = IncomingEmail.order(created_at: :desc).page(params[:page]).per(10)
  end


  def new
    @incoming_email = IncomingEmail.new
  end

  def create
    @incoming_email = IncomingEmail.new(incoming_email_params)

    if @incoming_email.save!
      ProcessIncomingEmailWorker.perform_async(@incoming_email.id)
      redirect_to incoming_emails_path, notice: 'File sent and background processing started, please wait'
    else
      render :new
    end
  end

  def show
    @incoming_email = IncomingEmail.find(params[:id])
  end

  private
  def incoming_email_params
    params.require(:incoming_email).permit(:file)
  end

  def missing_file
    flash[:alert] = "File is required."
    redirect_back fallback_location: incoming_emails_path
  end
end
