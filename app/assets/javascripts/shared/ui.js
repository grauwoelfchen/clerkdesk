(function($) {
  'use strict';

  $('.main .ui.sticky').sticky({
    context: '#right_menu'
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
