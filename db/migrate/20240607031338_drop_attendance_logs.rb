class DropAttendanceLogs < ActiveRecord::Migration[7.0]
  def change
    drop_table :attendance_logs
  end
end
