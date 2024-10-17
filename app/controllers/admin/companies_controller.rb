class Admin::CompaniesController < Admin::BaseController

  def index
    @companies = Company.all

    @q = @companies.ransack(params[:q])
    @pagy, @companies = pagy(@q.result, limit: 10)
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      flash[:success] = "Company updated successfully!"
      redirect_to admin_company_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to admin_companies_path
  end

  private

    def company_params
      params.require(:company).permit(:name)
    end

end
