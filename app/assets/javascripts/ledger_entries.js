(function($) {
  'use strict';

  $(function() {
    var type         = $('#ledger_entry_type')
      , journalizing = $('#ledger_entry_journalizing_id')
      ;

    // indicator
    $(journalizing).parent().append(
      '<span id="indicator"><img src="/assets/loading.gif"></div>'
    );
    $('#indicator').css({
      display:          'none',
      margin:           '7px 0 2px 0',
      padding:          '0',
      'vertical-align': 'middle'
    });
    $(document).ajaxStart(function() {
      journalizing.hide();
      $('#indicator').css({display: 'inline-block'});
    }).ajaxStop(function() {
      $('#indicator').hide();
      journalizing.show();
    });

    // journalizings updater
    var setJournalizingOptions = function(type_val, journalizing_val) {
      if (typeof journalizing_val === "undefined") {
        journalizing_val = null;
      }
      $.ajax({
        dataType: 'json',
        url:      '/finances/3/journalizings.json?type=' +
          encodeURIComponent(type_val)
      })
      .fail(function() {
        journalizing.empty();
        journalizing.html('<option value="">---</option>');
        type.val('');
        alert("Sorry, please retry :'(");
      })
      .done(function(data) {
        journalizing.empty();
        data.unshift({name: '---', id: ''});
        $(data).each(function(key, value) {
          var id   = $('<div/>').text(value.id).html()
            , name = $('<div/>').text(value.name).html()
            ;
          journalizing.append(
            '<option value="' + id + '">' + name + '</option>'
          );
        });
        if (journalizing_val) {
          journalizing.val(journalizing_val).prop('selected', true);
        }
        return true;
      });
    };
    var type_val         = type.val()
      , journalizing_val = journalizing.val()
      ;

    // initialize
    if (type_val) {
      setJournalizingOptions(type_val, journalizing_val);
    }

    type.change(function() {
      var type_val = $(this).val(); // refetch
      if (type_val == '') {
        journalizing.empty();
        journalizing.html('<option value="">---</option>');
        return true;
      }
      return setJournalizingOptions(type_val);
    });
  });

  // total_amount (currency)
  $(function() {
    var amount = $('#ledger_entry_total_amount');

    // TODO currency setting
    amount.autoNumeric('init', {
      aSign:  '¥ ',
      pSign:  'p',
      vMin:   '-100000000',
      vMax:   '100000000',
      wEmpty: 'zero',
      lZero:  'deny'
    });

    $('#ledger_entry_type').change(function() {
      var current_value = amount.autoNumeric('get');
      amount.autoNumeric('set', 0);
      if ($(this).val() === 'income') {
        amount.autoNumeric('update', {
          vMin: '0',
          vMax: '100000000'
        });
        var value = (current_value < 0) ? current_value * -1 : current_value;
        amount.autoNumeric('set', value);
      } else {
        amount.autoNumeric('update', {
          vMin: '-100000000',
          vMax: '0'
        });
        var value = (current_value > 0) ? current_value * -1 : current_value;
        amount.autoNumeric('set', value);
      }
    });

    $('form.form').submit(function() {
      var current_value = amount.autoNumeric('get');
      amount.autoNumeric('update', {
        aSign: '',
        aSep:  '',
        aDeg:  ''
      });
    });
  });
})(jQuery);
