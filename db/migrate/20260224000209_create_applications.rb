class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.integer :listing_id
      t.integer :user_id
      t.text :message_to_owner
      t.integer :priority_rank
      t.string :status
      t.text :decision_notes

      t.timestamps
    end
  end
end
