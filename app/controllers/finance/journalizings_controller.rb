module Finance
  class JournalizingsController < WorkspaceController
    before_action :set_ledger
    before_action :set_account

    def index
      journalizings = @account.journalizings.category_type(params[:type])
      respond_to do |format|
        format.json { render :json => journalizings.to_json }
      end
    end

    private

    def set_ledger
      @ledger = Ledger.find(params[:ledger_id])
    end

    def set_account
      @account = @ledger.accounts.find(params[:account_id])
    end
  end
end
