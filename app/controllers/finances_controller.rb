class FinancesController < WorkspaceController
  before_action :load_finance, only: [:show, :edit, :update, :destroy]

  def index
    @finances = Finance.ordered(params[:column], params[:direction])
      .page(params[:page])
  end

  def new
    now = Time.now
    default = {
      :started_at  => now + 1.hour,
      :finished_at => now + 1.year
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
    @finance = Finance.find(params[:id])
  end

  def finance_params
    params.require(:finance).permit(
      :name, :description, :started_at, :finished_at, :status)
  end
end
