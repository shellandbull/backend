class AddOwnerToOauthApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :oauth_applications, :owner_id, :integer, null: true
    add_index :oauth_applications, [:owner_id]
  end
end
