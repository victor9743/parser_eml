require "rails_helper"

RSpec.describe "IncomingEmails", type: :request do
  it "uploads an eml and enqueues a job" do
    file = fixture_file_upload("spec/fixtures/files/fornecedor_a_ok.eml", "message/rfc822")

    expect {
      post incoming_emails_path, params: { incoming_email: { file: file } }
    }.to change(IncomingEmail, :count).by(1)

    expect(response).to redirect_to(incoming_emails_path)

    # Verifique se o job foi enfileirado
    expect(ProcessIncomingEmailJob).to have_enqueued_job
  end

end
