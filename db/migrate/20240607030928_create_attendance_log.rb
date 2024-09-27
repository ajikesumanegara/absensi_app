class CreateAttendanceLog < ActiveRecord::Migration[7.0]
  def change
    create_table :attendance_logs do |t|

      t.timestamps
    end
  end
end
