module.exports = {
  setup: function($, container) {
    'use strict';

    $('#indicator').css({
      display:          'none'
    , margin:           '7px 0 2px 0'
    , padding:          '0'
    , 'vertical-align': 'middle'
    });

    $(document).ajaxStart(function() {
      container.hide();
      $('#indicator').css({display: 'inline-block'});
    }).ajaxStop(function() {
      $('#indicator').hide();
      container.show();
    });
  }
};
