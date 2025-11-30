require 'rails_helper'

RSpec.describe IncomingEmail do
  it 'is valid with sender and file' do
    email = described_class.new(sender: 'test@example.com')
    email.file.attach(io: File.open('spec/fixtures/files/fornecedor_a_ok.eml'), filename: 'email.eml')
    expect(email).to be_valid
  end
end
