# app/models/customer.rb
class Customer < ApplicationRecord
  validates :name, presence: true
  validate :contact_present
  belongs_to :incoming_email

  def contact_present
    return unless email.blank? && phone.blank?

    errors.add(:base, 'Need email and phone')
  end
end
