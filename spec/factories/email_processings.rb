FactoryBot.define do
  factory :email_processing do
    incoming_email { nil }
    success { false }
    extracted_data { '' }
    error_message { 'MyText' }
  end
end
