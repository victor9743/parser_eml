class Customer < ApplicationRecord
    validates :name, presence: true
    validate :contact_present

    def contact_present
      if email.blank? && phone.blank?
          errors.add(:base, "Need email and phone")
      end
    end
end
