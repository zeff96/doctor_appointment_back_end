class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :consultation_fee
      t.integer :doctor, null: false, foreign_key: { to_table: :doctors }


      t.timestamps
    end
  end
end
