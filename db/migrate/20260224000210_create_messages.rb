class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :application_id
      t.integer :sender_id
      t.text :body

      t.timestamps
    end
  end
end
