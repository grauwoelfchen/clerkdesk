(function($) {
  'use strict';

  $(function() {
    // tag editor
    (function() {
      if ($.fn.tagEditor == undefined) { return; }

      var tagList = $('#note_tag_list');
      tagList.tagEditor({
        'delimiter':      ','
      , 'forceLowercase': false
      , 'placeholder':    'Tag'
      });
    })();

    // autosize
    (function() {
      if ($.fn.autosize == undefined) { return; }

      var textarea = $('#note_content');
      textarea.autosize();
    })();
  });
})(jQuery);
