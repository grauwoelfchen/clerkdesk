class BudgetsController < WorkspaceController
  before_action :load_budget, :only => [:show, :edit, :update, :destroy]

  def index
    @budgets = Budget.all
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to @budget, :notice => "Budget has been successfully created."
    else
      flash.now[:alert] = "Budget could not be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @budget.update_attributes(budget_params)
      redirect_to @budget, :notice => "Budget has been successfully updated."
    else
      flash.now[:alert] = "Budget could not be updated."
      render :edit
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_url, 
      :notice => "Budget has been successfully destroyed."
  end

  private

  def load_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:title)
  end
end
