//= require jquery-autosize/jquery.autosize.min.js
//= require jquery-ui/jquery-ui.min.js
//= require jquery-ui/ui/minified/autocomplete.min.js
//= require jquery-tag-editor/jquery.caret.min.js
//= require jquery-tag-editor/jquery.tag-editor.min.js

(function($) {
  'use strict';

  $(function() {
    // tag editor
    (function() {
      if ($.fn.tagEditor == undefined) { return; }

      var tagList = $('#snippet_tag_list');
      tagList.tagEditor({
        'delimiter':      ','
      , 'forceLowercase': false
      , 'placeholder':    'Tag'
      });
    })();

    // autosize
    (function() {
      if ($.fn.autosize == undefined) { return; }

      var textarea = $('#snippet_content');
      textarea.autosize();
    })();
  });
})(jQuery);
