class AddTimestampsToAttendance < ActiveRecord::Migration[7.0]
  def change
    add_timestamps(:attendances)
  end
end
