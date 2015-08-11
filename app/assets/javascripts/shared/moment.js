(function($, moment) {
  'use strict';

  if (moment == undefined) { return; }

  moment.locale('ja', {
    longDateFormat: {
      LT:   'HH:mm'
    , LTS:  'HH:mm:ss'
    , L:    'YYYY-MM-DD'
    , LL:   'YYYY年 MM月 DD日'
    , LLL:  'YYYY MMMM D LT'
    , LLLL: 'YYYY年 M月 D日 a h:mm:s dddd'
    , LLLL: 'YYYY年MM月DD日 hh:mm:ss dddd'
    }
  });

  // setup localized time
  $(function() {
    var locale = $('html').attr('lang');
    moment().format();
    moment.locale(locale);

    var datetime = '.created_at,.updated_at,' +
      '.started_at,.finished_at,.joined_at,.left_at';

    $(datetime).each(function() {
      var field = $(this)
        , value = moment.utc(field.html(), [
            'YYYY-MM-DD HH:mm:ssZ', moment.ISO_8601
          ])
        ;
      if (value.isValid()) {
        value.locale(locale); // local locale
        value.local();
        var data = field.attr('data-format');
        switch (data) {
          case 'relative':
          case 'fromNow':
            field.html(value.fromNow());
            break;
          case 'calendar':
            field.html(value.calendar());
            break;
          case undefined: // full
            field.html(value.format('LLLL'));
            break;
          default:
            field.html(value.format(data));
            break;
        }
      }
    });
  });
})(jQuery, moment);
