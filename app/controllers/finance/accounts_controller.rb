module Finance
  class AccountsController < WorkspaceController
    before_action :set_report
    before_action :set_account, only: [:show, :edit, :update]

    def index
      @accounts = @report.accounts.page(params[:page])
    end

    def new
      @account = @report.accounts.new
    end

    def create
      @account = @report.accounts.new(account_params)
      if @account.save_with_category
        redirect_to(finance_report_account_url(@report, @account),
          :notice => 'Account has been successfully created.')
      else
        flash.now[:alert] = 'Account could not be created.'
        render(:new)
      end
    end

    def show
    end

    def edit
    end

    def update
      if @account.update_attributes(account_params)
        redirect_to(finance_report_account_url(@report, @account),
          :notice => 'Account has been successfully updated.')
      else
        flash.now[:alert] = 'Account could not be updated.'
        render(:edit)
      end
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_account
      @account = @report.accounts.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :description, :icon)
    end
  end
end
