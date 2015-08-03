(function($) {
  'use strict';
  $(function() {
    if (!location.href.match(/account_books/)) { return; }

    (function() {
      if ($.fn.selectric == undefined) { return; }

      var renderIconItem = function(label, value) {
        if (value.length) {
          return '<span class="item">' +
                 '<i class="fa fa-fw fa-lg">' + value + '</i>' +
                 label +
                 '</span>';
        } else {
          return label;
        }
      }

      $('#account_book_icon').selectric({
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
