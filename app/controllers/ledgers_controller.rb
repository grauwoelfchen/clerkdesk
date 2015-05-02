class LedgersController < WorkspaceController
  before_filter :load_account

  def index
    @ledgers = @account.ledgers
  end

  private

  def load_account
    @account = Account.find(params[:account_id])
  end
end
