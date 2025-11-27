class IncomingEmail < ApplicationRecord
    has_one_attached :file
    has_many :email_processings, dependent: :destroy
    validates :filename, presence: true
end
