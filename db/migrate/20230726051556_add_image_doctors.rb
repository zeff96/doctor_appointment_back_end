class AddImageDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :image, :string
  end
end
