class RenameUserAsOwnerColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :as_owner?, :as_owner
  end
end
