class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :consultation_fee
      t.integer :doctor_id


      t.timestamps
    end
  end
end
