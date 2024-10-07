class AddAsAdminFlagToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :as_admin, :boolean, default: false
  end
end
