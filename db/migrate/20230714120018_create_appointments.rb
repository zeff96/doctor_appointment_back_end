class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.date :appointment_date
      t.integer :doctor_id
      t.integer :patient_id, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
