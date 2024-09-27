class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.timestamp :clock_in
      t.timestamp :clock_out
    end
  end
end
