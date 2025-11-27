class CreateEmailProcessings < ActiveRecord::Migration[7.1]
  def change
    create_table :email_processings do |t|
      t.references :incoming_email, null: false, foreign_key: true
      t.boolean :success, null: false, default: false
      t.jsonb :extracted_data, default: {}
      t.text :error_message

      t.timestamps
    end
  end
end
