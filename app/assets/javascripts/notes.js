(function($) {
  'use strict';
  $(function() {
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
