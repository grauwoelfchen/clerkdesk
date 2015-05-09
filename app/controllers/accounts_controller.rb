class AccountsController < WorkspaceController
  before_action :load_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.ordered(params[:column], params[:direction])
      .page(params[:page])
  end

  def new
    now = Time.now
    default = {
      :started_at  => now + 1.hour,
      :finished_at => now + 1.year
    }
    @account = Account.new(default)
  end

  def create
    @account = Account.new(account_params)
    if @account.save_with_budget_and_settlement
      redirect_to @account, :notice => "Account has been successfully created."
    else
      flash.now[:alert] = "Account could not be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @account.update_attributes(account_params)
      redirect_to @account, :notice => "Account has been successfully updated."
    else
      flash.now[:alert] = "Account could not be updated."
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url,
      :notice => "Account has been successfully destroyed."
  end

  private

  def load_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(
      :name, :description, :started_at, :finished_at, :status)
  end
end
