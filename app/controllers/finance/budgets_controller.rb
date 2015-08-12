module Finance
  class BudgetsController < WorkspaceController
    before_action :set_report
    before_action :set_budget

    def show
    end

    def edit
    end

    def update
      if @budget.update_attributes(budget_params)
        redirect_to(finance_report_budget_url(@report),
          :notice => 'Budget has been successfully updated.')
      else
        flash.now[:alert] = 'Budget could not be updated.'
        render(:edit)
      end
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_budget
      @budget = @report.budget or
        raise ActiveRecord::RecordNotFound
    end

    def budget_params
      params.require(:budget).permit(:description, :memo)
    end
  end
end
