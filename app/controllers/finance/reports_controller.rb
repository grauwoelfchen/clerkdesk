module Finance
  class ReportsController < WorkspaceController
    before_action :set_report, only: [:show, :edit, :update, :destroy]

    def index
      @reports = Report
        .sort(params[:field], params[:direction])
        .page(params[:page])
    end

    def new
      @report = Report.new
    end

    def create
      @report = Report.new(report_params)
      if @report.save_with_fiscal_objects
        redirect_to([:overview, :finance, @report],
          :notice => 'Finance report has been successfully created.')
      else
        flash.now[:alert] = 'Finance report could not be created.'
        render(:new)
      end
    end

    def show
      if params[:segment] == 'status'
        @categories = @report.recent_categories
      else # entries
        @entries = @report.recent_entries
      end
    end

    def edit
    end

    def update
      if @report.update_attributes(report_params)
        redirect_to([:overview, :finance, @report],
          :notice => 'Finance report has been successfully updated.')
      else
        flash.now[:alert] = 'Finance report could not be updated.'
        render(:edit)
      end
    end

    def destroy
      @report.destroy
      redirect_to(finance_reports_url,
        :notice => 'Finance report has been successfully destroyed.')
    end

    private

    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(
        :name, :state, :description, :started_at, :finished_at)
    end
  end
end
