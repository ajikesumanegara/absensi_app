class RenameUserColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :full_name
  end
end
