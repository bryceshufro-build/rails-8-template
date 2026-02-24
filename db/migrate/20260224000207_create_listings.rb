class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.integer :owner_id
      t.string :title
      t.string :address
      t.string :neighborhood
      t.integer :bedrooms
      t.decimal :bathrooms
      t.integer :monthly_rent
      t.date :available_on
      t.date :lease_end_on
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
