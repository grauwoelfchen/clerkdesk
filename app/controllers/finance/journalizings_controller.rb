module Finance
  class JournalizingsController < WorkspaceController
    before_action :set_report
    before_action :set_account_book

    def index
      journalizings = @account_book.journalizings.category_type(params[:type])
      respond_to do |format|
        format.json { render :json => journalizings.to_json }
      end
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_account_book
      @account_book = @report.account_books.find(params[:account_book_id])
    end
  end
end
