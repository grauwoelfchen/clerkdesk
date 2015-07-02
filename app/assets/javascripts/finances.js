(function($) {
  'use strict';
  $(function() {
    var locale = $('html').attr('lang')
      , locales = {
          'en': {
            days:        ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            daysShort:   ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            daysMin:     ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
            months:      ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            monthsShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
          }
        , 'ja': {
            days:        ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'],
            daysShort:   ['日曜', '月曜', '火曜', '水曜', '木曜', '金曜', '土曜', '日曜'],
            daysMin:     ['日', '月', '火', '水', '木', '金', '土', '日'],
            months:      ['１月', '２月', '３月', '４月', '５月', '６月', '７月', '８月', '９月', '１０月', '１１月', '１２月'],
            monthsShort: ['１月', '２月', '３月', '４月', '５月', '６月', '７月', '８月', '９月', '１０月', '１１月', '１２月']
          }
        };

    $('input.date').pickmeup({
      position:       'right'
    , hide_on_select: true
    , format:         'Y-m-d'
    , locale:         locales[locale]
    });

    var textarea = $('#finance_description');
    textarea.autosize();
  });

})(jQuery);
