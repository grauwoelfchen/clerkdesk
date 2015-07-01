class BudgetsController < WorkspaceController
  include FinancialPlanner

  before_action :load_finance
  before_action :load_budget

  def show
  end

  def edit
  end

  def update
    if @budget.update_attributes(budget_params)
      redirect_to financial_url(@finance, :finance_budget),
        :notice => "Budget has been successfully updated."
    else
      flash.now[:alert] = "Budget could not be updated."
      render :edit
    end
  end

  private

  def load_finance
    @finance = Finance.find_or_primary(params[:finance_id])
  end

  def load_budget
    @budget = @finance.budget or
      raise ActiveRecord::RecordNotFound
  end

  def budget_params
    params.require(:budget).permit(:title, :description)
  end
end
