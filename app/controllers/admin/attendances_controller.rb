class Admin::AttendancesController < Admin::BaseController

  def index
    @attendances = Attendance.all
  end
end
