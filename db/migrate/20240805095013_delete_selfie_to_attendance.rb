class DeleteSelfieToAttendance < ActiveRecord::Migration[7.0]
  def change
    remove_column :attendances, :selfie
  end
end
