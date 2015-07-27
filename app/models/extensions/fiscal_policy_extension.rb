module FiscalPolicyExtension
  # Return model_name with namespace
  #
  # Finance module's `use_relative_model_naming?` is still false.
  # This omits only model's namespace in route_key.
  # `url_for([:finance, report, category])` works as finance_report_category_path(report, category).
  #
  # see also:
  # https://github.com/rails/rails/blob/0edb6465971f7d937fce2bf0a8e1e2b540d56e0a/activemodel/lib/active_model/naming.rb#L146
  # http://api.rubyonrails.org/classes/ActiveModel/Naming.html#method-i-model_name
  def model_name
    # pass namespage 'Finance'
    namespace = OpenStruct.new
    namespace.name = self.name.sub("::#{self.class_name}", "")
    @_model_name = ActiveModel::Name.new(self, namespace)
    super
  end
end
