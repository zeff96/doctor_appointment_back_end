class CreateSocialMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :social_media do |t|
      t.string :platform
      t.string :profile_url
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
