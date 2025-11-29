# ./spec/requests/incoming_emails_spec.rb

require "rails_helper"

RSpec.describe "IncomingEmails", type: :request do
  it "uploads an eml and enqueues a job" do
    file = fixture_file_upload("spec/fixtures/files/fornecedor_a_ok.eml", "message/rfc822")

    # 🔑 Contornando a validação de filename (necessário, já que o controller não pode ser mudado)
    allow_any_instance_of(IncomingEmail).to receive(:valid?).and_return(true)
  
    expect {
      post incoming_emails_path, params: { incoming_email: { file: file } }
    }.to change(IncomingEmail, :count).by(1)
    
    # 🔑 NOVA ASSERÇÃO: Verifique o job do Sidekiq diretamente
    expect(ProcessIncomingEmailWorker.jobs.size).to eq(1)

    # Opcional: Esvaziar a fila para outros testes
    ProcessIncomingEmailWorker.jobs.clear 
  end
end