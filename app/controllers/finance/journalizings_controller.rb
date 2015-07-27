module Finance
  class JournalizingsController < WorkspaceController
    before_action :load_report
    before_action :load_account_book

    def index
      journalizings = @report.categories.includes(:journalizings)
        .where_type(params[:type])
        .where("#{Journalizing.table_name}.account_book_id" => @account_book)
        .map { |category|
          {:name => category.name, :id => category.journalizings.first.id}
        }
      respond_to do |format|
        format.json { render :json => journalizings.to_json }
      end
    end

    private

    def load_report
      @report = Report.find(params[:report_id])
    end

    def load_account_book
      @account_book = @report.account_books.find(params[:account_book_id])
    end
  end
end
