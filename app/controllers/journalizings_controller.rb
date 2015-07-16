class JournalizingsController < WorkspaceController
  before_action :load_finance

  def index
    # TODO currently, only single ledger support
    journalizings = @finance.categories.includes(:journalizings)
      .where_type(params[:type])
      .where("journalizings.ledger_id" => @finance.ledger)
      .map { |category|
        {:name => category.name, :id => category.journalizings.first.id}
      }
    respond_to do |format|
      format.json { render :json => journalizings.to_json }
    end
  end

  private

  def load_finance
    @finance = Finance.find(params[:finance_id])
  end
end
