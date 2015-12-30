class CountriesController < WorkspaceController
  before_action :set_country

  def divisions
    divisions = @country.subdivisions.sort.map { |n, v|
      {:code => n, :name => v['name']}
    }
    respond_to do |format|
      format.json { render(:json => divisions.to_json) }
    end
  end

  private

  def set_country
    @country = ISO3166::Country.find_country_by_alpha2(params[:code])
  end
end
