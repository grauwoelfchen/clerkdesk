module Finance
  class AccountBooksController < WorkspaceController
    before_action :load_report
    before_action :load_account_book, only: [:show, :edit, :update, :destroy]

    def index
      @account_books = @report.account_books.page(params[:page])
    end

    def new
      @account_book = @report.account_books.new
    end

    def create
      @account_book = @report.account_books.new(account_book_params)
      if @account_book.save
        # TODO
        @report.categories.map do |category|
          category.journalizings.create(:account_book => @account_book)
        end
        redirect_to finance_report_account_book_url(@report, @account_book),
          :notice => "AccountBook book has been successfully created."
      else
        flash.now[:alert] = "AccountBook book could not be created."
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @account_book.update_attributes(account_book_params)
        redirect_to finance_report_account_book_url(@report, @account_book),
          :notice => "AccountBook book has been successfully updated."
      else
        flash.now[:alert] = "AccountBook book could not be updated."
        render :edit
      end
    end

    private

    def load_report
      @report = Report.find(params[:report_id])
    end

    def load_account_book
      @account_book = @report.account_books.find(params[:id])
    end

    def account_book_params
      params.require(:account_book).permit(:name, :description)
    end
  end
end
