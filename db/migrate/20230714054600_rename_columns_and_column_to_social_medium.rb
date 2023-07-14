class RenameColumnsAndColumnToSocialMedium < ActiveRecord::Migration[7.0]
  def change
    rename_column :social_media, :platform, :facebook
    rename_column :social_media, :profile_url, :twitter

    add_column :social_media, :instagram, :string
  end
end
