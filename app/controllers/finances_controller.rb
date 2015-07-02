class FinancesController < WorkspaceController
  include FinancialPlanner

  before_action :load_finance, :only => [:show, :edit, :update, :destroy]

  def index
    @finances = Finance
      .sort(params[:field], params[:direction])
      .page(params[:page])
  end

  def new
    today = Time.zone.today
    default = {
      :started_at  => today,
      :finished_at => today + 1.year
    }
    @finance = Finance.new(default)
  end

  def create
    @finance = Finance.new(finance_params)
    if @finance.save_with_fiscal_objects
      redirect_to @finance, :notice => "Finance has been successfully created."
    else
      flash.now[:alert] = "Finance could not be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @finance.update_attributes(finance_params)
      redirect_to @finance, :notice => "Finance has been successfully updated."
    else
      flash.now[:alert] = "Finance could not be updated."
      render :edit
    end
  end

  def destroy
    @finance.destroy
    redirect_to finances_url,
      :notice => "Finance has been successfully destroyed."
  end

  private

  def load_finance
    @finance = Finance.find_or_primary(params[:id])
  end

  def finance_params
    params.require(:finance).permit(
      :name, :state, :description, :started_at, :finished_at)
  end
end
