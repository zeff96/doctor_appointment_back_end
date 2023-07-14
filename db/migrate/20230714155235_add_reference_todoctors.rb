class AddReferenceTodoctors < ActiveRecord::Migration[7.0]
  def change
    add_reference :doctors, :user, foreign_key: true
  end
end
