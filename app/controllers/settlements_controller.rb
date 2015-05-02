class SettlementsController < WorkspaceController
  before_action :load_account
  before_action :load_settlement

  def show
  end

  def edit
  end

  def update
    if @settlement.update_attributes(settlement_params)
      redirect_to account_settlement_url(@account),
        :notice => "Settlement has been successfully updated."
    else
      flash.now[:alert] = "Settlement could not be updated."
      render :edit
    end
  end

  private

  def load_account
    @account = Account.find(params[:account_id])
  end

  def load_settlement
    @settlement = @account.settlement
  end

  def settlement_params
    params.require(:settlement).permit(:title, :description)
  end
end
