class AddSelfieUrlToAttendance < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :selfie_url, :text
  end
end
