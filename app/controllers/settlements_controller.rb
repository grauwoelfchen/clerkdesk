class SettlementsController < WorkspaceController
  before_action :load_finance
  before_action :load_settlement

  def show
  end

  def edit
  end

  def update
    if @settlement.update_attributes(settlement_params)
      redirect_to [@finance, :settlement],
        :notice => "Settlement has been successfully updated."
    else
      flash.now[:alert] = "Settlement could not be updated."
      render :edit
    end
  end

  private

  def load_finance
    @finance = Finance.find(params[:finance_id])
  end

  def load_settlement
    @settlement = @finance.settlement or
      raise ActiveRecord::RecordNotFound
  end

  def settlement_params
    params.require(:settlement).permit(:title, :description)
  end
end
