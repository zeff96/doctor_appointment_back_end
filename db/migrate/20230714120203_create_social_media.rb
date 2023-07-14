class CreateSocialMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :social_media do |t|
      t.string :platform
      t.string :profile_url
      t.integer :doctor, null: false, foreign_key: { to_table: :doctors }

      t.timestamps
    end
  end
end
