module Finance
  module ReportsHelper
    # Report label tag for enum value
    #
    # @param report [Finance::Report]
    # @param attribute [<Symbol, String>]
    #
    #   finance_label(finance, :state)
    #
    def report_label(report, attribute)
      option = {class: send("report_#{attribute}_label_class", report)}
      content_tag('span', report.send("human_#{attribute}"), option)
    end

    private

    def report_state_label_class(report)
      case report.state
      when 'closed'  then 'label label-disabled'
      when 'opened'  then 'label label-active'
      when 'primary' then 'label label-primary'
      else ''
      end
    end
  end
end
