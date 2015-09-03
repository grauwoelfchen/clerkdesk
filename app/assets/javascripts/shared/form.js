(function($) {
  'use strict';

  $('.form').on('submit', function() {
    $(this).addClass('loading');
  });
})(jQuery);
