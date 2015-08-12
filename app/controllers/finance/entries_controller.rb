module Finance
  class EntriesController < WorkspaceController
    before_action :set_report
    before_action :set_account_book
    before_action :set_journalizings, only: [:new, :create, :edit, :update]
    before_action :set_entry,         only: [:show, :edit, :update, :destroy]

    def index
      @entries = @account_book.entries
        .includes(:journalizing, :category)
        .sort(params[:field], params[:direction])
        .page(params[:page])
    end

    def new
      @entry = @account_book.entries.new
    end

    def create
      @entry = @account_book.entries.build(entry_params)
      if @entry.save
        redirect_to([:finance, @report, @account_book, @entry],
          :notice => 'Entry has been successfully created.')
      else
        flash.now[:alert] = 'Entry could not be created.'
        render(:new)
      end
    end

    def show
    end

    def edit
    end

    def update
      if @entry.update_attributes(entry_params)
        redirect_to([:finance, @report, @account_book, @entry],
          :notice => 'Entry has been successfully updated.')
      else
        flash.now[:alert] = 'Entry could not be updated.'
        render(:edit)
      end
    end

    def destroy
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_account_book
      @account_book = @report.account_books.find(params[:account_book_id])
    end

    def set_journalizings
      @journalizings = @account_book.journalizings.includes(:category)
    end

    def set_entry
      @entry = @account_book.entries
        .includes(:people, :involvements, :category)
        .find(params[:id])
    end

    def entry_params
      permitted_params = params.require(:entry).permit(
        :title, :type, :journalizing_id, :total_amount, :memo,
        :involvements_attributes => [
          :id, :holder_id, :holder_type, :_destroy
        ]
      )
      # sanitize
      permitted_params[:total_amount].to_s.gsub!(/[^0-9\-]/, '')
      permitted_params
    end
  end
end
