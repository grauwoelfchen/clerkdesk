module Finance
  class TransactionsController < WorkspaceController
    before_action :set_ledger
    before_action :set_account
    before_action :set_journalizings, only: [:new, :create, :edit, :update]
    before_action :set_transaction,         only: [:show, :edit, :update, :destroy]

    def index
      @transactions = @account.transactions
        .includes(:journalizing, :category)
        .order_by(params[:field], params[:direction])
        .page(params[:page])
      if params[:c]
        @category = Finance::Category.find(params[:c])
        @transactions = @transactions
          .includes(:category)
          .where(:finance_categories => {:id => params[:c]})
      end
    end

    def new
      @transaction = @account.transactions.new
    end

    def create
      @transaction = @account.transactions.build(transaction_params)
      if @transaction.save
        redirect_to([:finance, @ledger, @account, @transaction],
          :notice => 'Transaction has been successfully created.')
      else
        flash.now[:alert] = 'Transaction could not be created.'
        render(:new)
      end
    end

    def show
    end

    def edit
    end

    def update
      if @transaction.update_attributes(transaction_params)
        redirect_to([:finance, @ledger, @account, @transaction],
          :notice => 'Transaction has been successfully updated.')
      else
        flash.now[:alert] = 'Transaction could not be updated.'
        render(:edit)
      end
    end

    def destroy
    end

    private

    def set_ledger
      @ledger = Ledger.find(params[:ledger_id])
    end

    def set_account
      @account = @ledger.accounts.find(params[:account_id])
    end

    def set_journalizings
      @journalizings = @account.journalizings.includes(:category)
    end

    def set_transaction
      @transaction = @account.transactions
        .includes(:contacts, :involvements, :category)
        .find(params[:id])
    end

    def transaction_params
      permitted_params = params.require(:transaction).permit(
        :title, :type, :journalizing_id, :total_amount, :memo,
        :involvements_attributes => [
          :id, :holder_id, :holder_type, :_destroy
        ]
      )
      # sanitize
      permitted_params[:total_amount].to_s.gsub!(/[^0-9\-]/, '')
      permitted_params
    end
  end
end
