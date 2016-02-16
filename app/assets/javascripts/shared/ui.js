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

  var requestAnimationFrame = window.requestAnimationFrame
    || window.mozRequestAnimationFrame
    || window.webkitRequestAnimationFrame
    || window.msRequestAnimationFrame
    || function(callback) { setTimeout(callback, 0); };

  $('body').visibility({
    offset:         -9
  , observeChanges: false
  , once:           false
  , continues:      false
  , onTopPassed: function() {
      requestAnimationFrame(function() {
        $('.following.bar')
          .addClass('light fixed')
          .find('.menu')
          .removeClass('inverted');
      });
    }
  , onTopPassedReverse: function() {
      requestAnimationFrame(function() {
        $('.following.bar')
          .removeClass('light fixed')
          .find('.menu')
          .addClass('inverted');
      });
    }
  });
})(jQuery);
