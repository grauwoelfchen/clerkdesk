(function($) {
  'use strict';

  $(function() {
    if (!location.href.match(/notes/)) {
      return;
    }

    var tagList = $('#note_tag_list');
    tagList.tagEditor({
      'delimiter':      ','
    , 'forceLowercase': false
    , 'placeholder':    'Tag'
    });

    var textarea = $('#note_content');
    textarea.autosize();
  });
})(jQuery);
