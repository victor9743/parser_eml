# app/models/email_processing.rb
class EmailProcessing < ApplicationRecord
  belongs_to :incoming_email
end
