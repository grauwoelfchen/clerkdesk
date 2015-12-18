module Finance
  class AccountsController < WorkspaceController
    before_action :set_ledger
    before_action :set_account, only: [:edit, :update]

    def index
      @accounts = @ledger.accounts.page(params[:page])
    end

    def new
      @account = @ledger.accounts.new
    end

    def create
      @account = @ledger.accounts.new(account_params)
      if @account.save_with_category
        redirect_to(finance_ledger_account_entries_url(@ledger, @account),
          :notice => 'Account has been successfully created.')
      else
        flash.now[:alert] = 'Account could not be created.'
        render(:new)
      end
    end

    def edit
    end

    def update
      if @account.update_attributes(account_params)
        redirect_to(finance_ledger_account_entries_url(@ledger, @account),
          :notice => 'Account has been successfully updated.')
      else
        flash.now[:alert] = 'Account could not be updated.'
        render(:edit)
      end
    end

    private

    def set_ledger
      @ledger = Ledger.find(params[:ledger_id])
    end

    def set_account
      @account = @ledger.accounts.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :description, :icon)
    end
  end
end
