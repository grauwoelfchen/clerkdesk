module Finance
  class JournalizingsController < WorkspaceController
    before_action :set_report
    before_action :set_account

    def index
      journalizings = @account.journalizings.category_type(params[:type])
      respond_to do |format|
        format.json { render :json => journalizings.to_json }
      end
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def set_account
      @account = @report.accounts.find(params[:account_id])
    end
  end
end
