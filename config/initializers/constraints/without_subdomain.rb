module Constraints
  class WithoutSubdomain
    def self.matches?(request)
      request.subdomain.blank?
    end
  end
end
