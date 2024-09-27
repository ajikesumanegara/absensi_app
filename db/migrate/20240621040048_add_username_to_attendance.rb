class AddUsernameToAttendance < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :username, :string
  end
end
