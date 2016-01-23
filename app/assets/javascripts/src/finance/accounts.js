//= require jquery-selectric/public/jquery.selectric.min.js

(function($) {
  'use strict';

  $(function() {
    // set icon
    (function() {
      if ($.fn.selectric == undefined) { return; }

      var renderIconItem = function(label, value) {
        if (value == undefined || value.length == 0) {
          return label;
        }
        return '<span class="item">' +
          '<i class="icon fa fa-' + value + ' fa-lg"></i>' +
          label +
        '</span>';
      }

      $('#account_icon').selectric({
        maxHeight: 240
      , onInit: function() {
          var selected = $(this).find('option:selected')
            , label    = selected.html()
            , value    = selected.val()
            ;
          $('.selectric p.label').html(renderIconItem(label, value));
        }
      , onChange: function(element) {
          var label = $(element).find('option:selected').html()
            , value = $(element).val()
            ;
          $('.selectric p.label').html(renderIconItem(label, value));
          return $(element).change();
        }
      , optionsItemBuilder: function(itemData, element, index) {
          return renderIconItem(itemData.text, element.val());
        }
      });
    })();
  });
})(jQuery);
