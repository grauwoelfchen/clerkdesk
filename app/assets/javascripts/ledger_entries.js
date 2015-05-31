(function($) {
  'use strict';
  // total_amount (currency)
  $(function() {
    var amount = $('#ledger_entry_total_amount');

    // TODO currency setting
    amount.autoNumeric('init', {
      aSign:  '¥ ',
      pSign:  'p',
      vMin:   '-100000000',
      vMax:   '100000000',
      wEmpty: 'zero'
    });

    $('#ledger_entry_type').change(function() {
      var current_value = amount.autoNumeric('get');
      amount.autoNumeric('set', 0);
      if ($(this).val() === 'income') {
        amount.autoNumeric('update', {
          vMin: '0',
          vMax: '100000000'
        });
        var value = (current_value < 0) ? current_value * -1 : current_value;
        amount.autoNumeric('set', value);
      } else {
        amount.autoNumeric('update', {
          vMin: '-100000000',
          vMax: '0'
        });
        var value = (current_value > 0) ? current_value * -1 : current_value;
        amount.autoNumeric('set', value);
      }
    });

    $('form.form').submit(function() {
      var current_value = amount.autoNumeric('get');
      amount.autoNumeric('update', {
        aSign: '',
        aSep:  '',
        aDeg:  ''
      });
    });
  });
})(jQuery);
