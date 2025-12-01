class AddIncomingEmailToCustomer < ActiveRecord::Migration[7.1]
  def change
    add_reference :customers, :incoming_email, null: false, foreign_key: true
  end
end
