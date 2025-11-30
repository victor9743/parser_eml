# ./spec/requests/incoming_emails_spec.rb
# rubocop:disable RSpecRails/InferredSpecType
require 'rails_helper'
RSpec.describe 'IncomingEmails', type: :request do
  describe 'POST /incoming_emails' do
    it 'creates a new incoming email to fornecedor a' do
      file = fixture_file_upload('spec/fixtures/files/fornecedor_a_ok.eml', 'message/rfc822')

      expect do
        post incoming_emails_path, params: { incoming_email: { file: file } }
      end.to change(IncomingEmail, :count).by(1)
    end

    it 'creates a new incoming email to to fornecedor b' do
      file = fixture_file_upload('spec/fixtures/files/contato_parceiro_b_ok.eml', 'message/rfc822')

      expect do
        post incoming_emails_path, params: { incoming_email: { file: file } }
      end.to change(IncomingEmail, :count).by(1)
    end
  end
end
# rubocop:enable RSpecRails/InferredSpecType
