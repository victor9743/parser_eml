class IncomingEmail < ApplicationRecord
  has_many :email_processings, dependent: :destroy
  has_one_attached :file

  validates :file, presence: true

  # before_validation :set_filename

  # private

  # def set_filename
  #   return unless file.attached?
  #   self.filename = file.filename.to_s
  # end
end