class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :doctor_name
      t.string :bio

      t.timestamps
    end
  end
end
