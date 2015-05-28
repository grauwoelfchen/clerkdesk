class CountriesController < WorkspaceController
  before_action :load_country

  def subdivisions
    sleep 0.3
    subdivisions = @country.subdivisions.sort.map { |n, v|
      {
        :code => n,
        :name => v['name'],
      }
    }
    respond_to do |format|
      format.json { render :json => subdivisions.to_json }
    end
  end

  private

  def load_country
    @country = Country.find_country_by_alpha2(params[:code])
  end
end
