class LedgersController < WorkspaceController
  before_action :load_finance
  before_action :load_ledger

  def show
    @entries = @ledger.entries
      .includes(:journalizing, :category)
      .sort(params[:field], params[:direction])
      .page(params[:page])
  end

  def edit
  end

  def update
    if @ledger.update_attributes(ledger_params)
      redirect_to financial_url(@finance, :ledger),
        :notice => "Ledger has been successfully updated."
    else
      flash.now[:alert] = "Ledger could not be updated."
      render :edit
    end
  end

  private

  def load_finance
    @finance = Finance.find_or_primary(params[:finance_id])
  end

  def load_ledger
    @ledger = @finance.ledger or
      raise ActiveRecord::RecordNotFound
  end

  def ledger_params
    params.require(:ledger).permit(:title, :description)
  end
end
