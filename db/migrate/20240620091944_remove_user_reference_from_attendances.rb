class RemoveUserReferenceFromAttendances < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :attendances, :users
    remove_index :attendances, :user_id
    remove_column :attendances, :user_id
  end
end
