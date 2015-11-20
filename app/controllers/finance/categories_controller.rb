module Finance
  class CategoriesController < WorkspaceController
    before_action :set_ledger
    before_action :set_category, only: [:edit, :update, :destroy]

    def index
      @categories = @ledger.categories
      respond_to do |format|
        format.html {
          @categories = @categories
            .order_by(params[:field], params[:direction])
            .page(params[:page])
          render(:index)
        }
        format.json { render(:json => @categories.to_json) }
      end
    end

    def new
      @category = @ledger.categories.new
    end

    def create
      @category = @ledger.categories.new(category_params)
      if @category.save_with_journalizings
        redirect_to(finance_ledger_categories_url(@ledger),
          :notice => 'Category has been successfully created.')
      else
        flash.now[:alert] = 'Category could not be created.'
        render(:new)
      end
    end

    def edit
    end

    def update
      if @category.update_attributes(category_params)
        redirect_to(finance_ledger_categories_url(@ledger),
          :notice => 'Category has been successfully updated.')
      else
        flash.now[:alert] = 'Category could not be updated.'
        render(:edit)
      end
    end

    def destroy
      @category.destroy
      redirect_to(finance_ledger_categories_url(@ledger),
        :notice => 'Category has been successfully destroyed.')
    end

    private

    def set_ledger
      @ledger = Ledger.find(params[:ledger_id])
    end

    def set_category
      @category = @ledger.categories.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :type)
    end
  end
end
