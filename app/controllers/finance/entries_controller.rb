module Finance
  class EntriesController < WorkspaceController
    before_action :set_ledger
    before_action :set_account
    before_action :set_journalizings, only: [:new, :create, :edit, :update]
    before_action :set_entry,         only: [:show, :edit, :update, :destroy]

    def index
      @entries = @account.entries
        .includes(:journalizing, :category)
        .sort(params[:field], params[:direction])
        .page(params[:page])
    end

    def new
      @entry = @account.entries.new
    end

    def create
      @entry = @account.entries.build(entry_params)
      if @entry.save
        redirect_to([:finance, @ledger, @account, @entry],
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
        redirect_to([:finance, @ledger, @account, @entry],
          :notice => 'Entry has been successfully updated.')
      else
        flash.now[:alert] = 'Entry could not be updated.'
        render(:edit)
      end
    end

    def destroy
    end

    private

    def set_ledger
      @ledger = Ledger.find(params[:ledger_id])
    end

    def set_account
      @account = @ledger.accounts.find(params[:account_id])
    end

    def set_journalizings
      @journalizings = @account.journalizings.includes(:category)
    end

    def set_entry
      @entry = @account.entries
        .includes(:contacts, :involvements, :category)
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
