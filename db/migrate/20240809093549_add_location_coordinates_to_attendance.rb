class AddLocationCoordinatesToAttendance < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :latitude, :float
    add_column :attendances, :longitude, :float
  end
end
