class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.integer :doctor, null: false, foreign_key: { to_table: :doctors }

      t.timestamps
    end
  end
end
