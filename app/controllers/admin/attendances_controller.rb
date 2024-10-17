class Admin::AttendancesController < Admin::BaseController

  def index
    @attendances = Attendance.all

    @employees = User.all

    @search_params = search_params
    @q = @attendances.ransack(@search_params)
    @pagy, @attendances = pagy(@q.result, limit: 10)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "All Employees's Attendance Report", template: "attendances/pdf_template/all_attendances", formats: [:html]
      end
    end
  end

  def show
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Detail Attendance Report", template: "attendances/pdf_template/details_attendance", formats: [:html], disposition: 'attachment'
      end
    end
  end

  private

    def search_params
      s_params = params.fetch(:q, {}).permit(:clock_in_gteq, :clock_in_lteq, :status_eq, :user_id_eq).to_h

      clock_in_gteq = s_params[:clock_in_gteq]
      clock_in_lteq = s_params[:clock_in_lteq]

      s_params[:clock_in_gteq] = clock_in_gteq.to_time.beginning_of_day if clock_in_gteq.present?
      s_params[:clock_in_lteq] = clock_in_lteq.to_time.end_of_day if clock_in_lteq.present?
      
      s_params
    end
end
