(function($) {
  'use strict';

  $(function() {
    if (!location.href.match(/ledger/)) {
      return;
    }

    if ($.fn.autoNumeric) {
      var amount = $('td.total_amount > span');

      amount.autoNumeric('init', {
        aSign:  '¥ ',
        pSign:  'p',
        vMin:   '-100000000',
        vMax:   '100000000',
        wEmpty: 'zero',
        lZero:  'deny'
      });
    }
  });
})(jQuery);
