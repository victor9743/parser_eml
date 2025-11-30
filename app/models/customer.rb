# app/models/customer.rb
class Customer < ApplicationRecord
  validates :name, presence: true
  validate :contact_present

  def contact_present
    return unless email.blank? && phone.blank?

    errors.add(:base, 'Need email and phone')
  end
end
