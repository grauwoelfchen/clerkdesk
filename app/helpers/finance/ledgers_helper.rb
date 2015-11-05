module Finance
  module LedgersHelper
    # Ledger label tag for enum value
    #
    # @param ledger [Finance::Ledger]
    # @param attribute [<Symbol, String>]
    #
    #   finance_label(finance, :state)
    #
    def ledger_label(ledger, attribute)
      option = {class: send("ledger_#{attribute}_label_class", ledger)}
      content_tag('span', ledger.send("human_#{attribute}"), option)
    end

    private

    def ledger_state_label_class(ledger)
      case ledger.state
      when 'closed'  then 'label label-disabled'
      when 'opened'  then 'label label-active'
      when 'primary' then 'label label-primary'
      else ''
      end
    end
  end
end
