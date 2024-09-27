class UpdateAttendanceTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :attendances, :username
    add_column :attendances, :status, :integer
    add_column :attendances, :details, :string
  end
end
