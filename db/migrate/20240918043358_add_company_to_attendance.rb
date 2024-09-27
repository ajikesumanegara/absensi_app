class AddCompanyToAttendance < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendances, :company, foreign_key: true
  end
end
