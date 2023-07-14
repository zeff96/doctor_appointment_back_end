class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
