class CompaniesController < ApplicationController
  before_action :logged_in?
  before_action :has_company?, except: [:new, :create]
  before_action :company_owner?, except: [:new, :create]

  def index
    @companies = Company.all
  end
  
  def new
    if current_user.company
      flash[:primary] = "Company already exists! You can't manage multiple companies."
      redirect_to root_path
    end

    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    current_user.company = @company
    current_user.as_owner = true

    if @company.save
      current_user.save
      flash[:success] = "Company created successfully!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update

  end

  def show
    @company = Company.find(params[:id])
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
