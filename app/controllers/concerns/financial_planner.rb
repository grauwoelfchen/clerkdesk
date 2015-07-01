module FinancialPlanner
  extend ActiveSupport::Concern

  included do
    def financial_url(finance, url_name, *args)
      financial_route_to(finance, url_name, 'url', args)
    end
    helper_method :financial_url

    def financial_path(finance, path_name, *args)
      financial_route_to(finance, path_name, 'path', args)
    end
    helper_method :financial_path

    private

    def financial_route_to(finance, route_name, type, *args)
      route = route_name.to_s + "_#{type}"
      if finance.state_primary?
        self.send(route.sub(/finance/, 'primary_finance'), *args)
      else
        route_args = [finance] + args
        self.send(route, *route_args)
      end
    end
  end
end
