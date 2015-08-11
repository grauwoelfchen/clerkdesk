(function($) {
  'use strict';

  if ($.fn.autoNumeric == undefined) { return; }

  $('.currency').autoNumeric('init', {
    aSign:  '¥ '
  , pSign:  'p'
  , vMin:   '-100000000'
  , vMax:   '100000000'
  , wEmpty: 'zero'
  , lZero:  'deny'
  });
})(jQuery);
