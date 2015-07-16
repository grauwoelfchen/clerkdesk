class FinanceCategoriesController < WorkspaceController
  before_action :load_finance
  before_action :load_category, :only => [:edit, :update, :destroy]

  def index
    @categories = @finance.categories
    respond_to do |format|
      format.html {
        @categories = @categories
          .sort(params[:field], params[:direction])
          .page(params[:page])
        render :index
      }
      format.json { render :json => @categories.to_json }
    end
  end

  def new
    @category = @finance.categories.new
  end

  def create
    @category = @finance.categories.new(category_params)
    if @category.save
      @category.journalizings.create(:ledger => @finance.ledger)
      redirect_to finance_categories_url(@finance),
        :notice => "Category has been successfully created."
    else
      flash.now[:alert] = "Category could not be created."
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to finance_categories_url(@finance),
        :notice => "Category has been successfully updated."
    else
      flash.now[:alert] = "Category could not be updated."
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to finance_categories_url(@finance),
      :notice => "Category has been successfully destroyed."
  end

  private

  def load_finance
    @finance = Finance.find(params[:finance_id])
  end

  def load_category
    @category = @finance.categories.find(params[:id])
  end

  def category_params
    params.require(:finance_category).permit(:name, :type)
  end
end
