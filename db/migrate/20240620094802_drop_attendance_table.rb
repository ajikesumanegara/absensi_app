class DropAttendanceTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :attendances
  end
end
