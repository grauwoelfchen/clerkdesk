class BudgetsController < WorkspaceController
  before_action :load_account
  before_action :load_budget

  def show
  end

  def edit
  end

  def update
    if @budget.update_attributes(budget_params)
      redirect_to account_budget_url(@account),
        :notice => "Budget has been successfully updated."
    else
      flash.now[:alert] = "Budget could not be updated."
      render :edit
    end
  end

  private

  def load_account
    @account = Account.find(params[:account_id])
  end

  def load_budget
    @budget = @account.budget
  end

  def budget_params
    params.require(:budget).permit(:title, :description)
  end
end
