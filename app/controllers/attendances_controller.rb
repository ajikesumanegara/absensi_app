class AttendancesController < ApplicationController
  before_action :clock_out_limit, only: [:update]
  before_action :logged_in?, except: [:new, :create]
  before_action :has_company?

  def index
    if current_user.as_owner
      @attendances = Attendance.where(company: current_company)
    else
      @attendances = Attendance.where(user: current_user)
    end

    @employees = current_company.users
    @search_params = search_params
    @q = @attendances.ransack(@search_params)
    @pagy, @attendances = pagy(@q.result, limit: 2)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "All Employees's Attendance Report", template: "attendances/pdf_template/all_attendances", formats: [:html]
      end
    end
  end

  def new
    unless request.path == root_path
      redirect_to root_path
    end

    @attendance = Attendance.new
  end

  def new_permission
    @attendance = Attendance.new
    render :new_permission
  end

  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.user = current_user
    @attendance.company = current_company
    @attendance.clock_in = DateTime.now

    if params[:context] == 'clock_in_time'
      if @attendance.valid?(:clock_in_time)
        @attendance.attach_file!(@attendance.selfie_url, :selfie)
        @attendance.save
        flash[:primary] = "Clock in successfully recorded."
        redirect_to edit_attendance_path(@attendance)
      else
        render :new, status: :unprocessable_entity
      end
    elsif params[:context] == 'permission_details'
      if @attendance.valid?(:permission_details)
        @attendance.save
        if @attendance.status == 'sick'
          flash[:success] = "Your sick leave report has been received. Get well soon!"
        elsif @attendance.status == 'leave'
          flash[:success] = "Your leave request has been successfully submitted and is being processed."
        end
        redirect_to root_path
      else
        render :new_permission, status: :unprocessable_entity
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

    if @attendance.user != current_user && !current_user.as_owner
      flash[:danger] = "You can't see attendance of another user!"
      redirect_to attendances_path
    end
  end

  def edit
    @attendance = Attendance.find(params[:id])
    
    if @attendance.clock_out.present?
      flash[:danger] = "Your attendance has been recorded and cannot be changed!"
      redirect_to root_path
    end
  end

  def edit_leave_early
    @attendance = Attendance.find(params[:id])
    
    if @attendance.clock_out.present?
      flash[:danger] = "Your attendance has been recorded and cannot be changed!"
      redirect_to root_path
    end
  end

  def update
    @attendance = Attendance.find(params[:id])

    if @attendance.update(attendance_params)
      if DateTime.now > clock_out_limit || @attendance.details.present?
        @attendance.clock_out = DateTime.now

        if @attendance.details.present?
          @attendance.status = 4
        else
          @attendance.status = 1
        end

        @attendance.save
        flash[:success] = "Your attendance has been successfully recorded. Keep up the good work!"
        redirect_to root_path
      else
        @attendance.errors.add(:base, "You have left before your work hours are completed. Please fill out the form below to continue with your clock-out, or return if you are not leaving yet.")
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private
    def attendance_params
      return {} unless params[:attendance]

      params.require(:attendance).permit(:clock_in, :status, :details, :user, :selfie_url, :latitude, :longitude)
    end

    def search_params
      s_params = params.fetch(:q, {}).permit(:clock_in_gteq, :clock_in_lteq, :status_eq, :user_id_eq).to_h

      clock_in_gteq = s_params[:clock_in_gteq]
      clock_in_lteq = s_params[:clock_in_lteq]

      s_params[:clock_in_gteq] = clock_in_gteq.to_time.beginning_of_day if clock_in_gteq.present?
      s_params[:clock_in_lteq] = clock_in_lteq.to_time.end_of_day if clock_in_lteq.present?
      
      s_params
    end

    def clock_out_limit
      @clock_out_limit = DateTime.now.change({ hour: 17, min: 0, sec: 0 })
    end
end
