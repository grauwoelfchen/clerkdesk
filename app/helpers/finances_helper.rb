module FinancesHelper
  # Finance label tag for enum value
  #
  # @param finance [Finance]
  # @param attribute [<Symbol, String>]
  #
  #   finance_label(finance, :state)
  #
  def finance_label(finance, attribute)
    option = {class: send("finance_#{attribute}_label_class", finance)}
    content_tag('span', finance.send("human_#{attribute}"), option)
  end

  private

  def finance_state_label_class(finance)
    case finance.state
    when 'closed'  then 'label label-disabled'
    when 'opened'  then 'label label-active'
    when 'primary' then 'label label-primary'
    else ''
    end
  end
end
