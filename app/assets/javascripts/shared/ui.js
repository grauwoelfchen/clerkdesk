(function($) {
  'use strict';

  $('.main .ui.sticky').sticky({
    context: '#right_menu'
  });

  $('.side-menu .item.bottom').popup({
    popup:        $('.side-menu .flowing.popup')
  , on:           'click'
  , inline:       true
  , hoverable:    true
  , distanceAway: 3
  , offset:       6
  , position:     'top right'
  , delay: {
      show: 300
    , hide: 600
    }
  });

  $('select.dropdown').dropdown();
})(jQuery);
