module Finance
  class LedgersController < WorkspaceController
    before_action :set_ledger, only: [:show, :edit, :update, :destroy]

    def index
      @ledgers = Ledger
        .order_by(params[:field], params[:direction])
        .page(params[:page])
    end

    def new
      @ledger = Ledger.new
    end

    def create
      @ledger = Ledger.new(ledger_params)
      if @ledger.save_with_fiscal_objects
        redirect_to([:overview, :finance, @ledger],
          :notice => 'Finance ledger has been successfully created.')
      else
        flash.now[:alert] = 'Finance ledger could not be created.'
        render(:new)
      end
    end

    def show
      @expense = @ledger.transactions.total_expense
      @income  = @ledger.transactions.total_income
      if params[:segment] == 'status'
        @categories = @ledger.recent_categories
      else # transactions
        @transactions = @ledger.recent_transactions
      end
    end

    def edit
    end

    def update
      if @ledger.update_attributes(ledger_params)
        redirect_to([:overview, :finance, @ledger],
          :notice => 'Finance ledger has been successfully updated.')
      else
        flash.now[:alert] = 'Finance ledger could not be updated.'
        render(:edit)
      end
    end

    def destroy
      @ledger.destroy
      redirect_to(finance_ledgers_url,
        :notice => 'Finance ledger has been successfully destroyed.')
    end

    private

    def set_ledger
      @ledger = Ledger.find(params[:id])
    end

    def ledger_params
      params.require(:ledger).permit(
        :name, :state, :description, :started_at, :finished_at)
    end
  end
end
