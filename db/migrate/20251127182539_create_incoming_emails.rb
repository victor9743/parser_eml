class CreateIncomingEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :incoming_emails do |t|
      t.string :filename
      t.string :sender
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
