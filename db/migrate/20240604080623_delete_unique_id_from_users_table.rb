class DeleteUniqueIdFromUsersTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :unique_id
  end
end
