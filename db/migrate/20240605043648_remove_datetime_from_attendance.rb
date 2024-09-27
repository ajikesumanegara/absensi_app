class RemoveDatetimeFromAttendance < ActiveRecord::Migration[7.0]
  def change
    remove_column :attendances, :time, :datetime
  end
end
