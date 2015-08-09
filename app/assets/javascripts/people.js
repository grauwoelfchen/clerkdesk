(function($) {
  'use strict';

  $(function() {
    // indicator
    (function() {
      var division = $('#person_division');

      $(division).parent().append(
        '<span id="indicator"><img src="/assets/loading.gif"></div>'
      );
      $('#indicator').css({
        display:          'none',
        margin:           '7px 0 2px 0',
        padding:          '0',
        'vertical-align': 'middle'
      });
      $(document).ajaxStart(function() {
        division.hide();
        $('#indicator').css({display: 'inline-block'});
      }).ajaxStop(function() {
        $('#indicator').hide();
        division.show();
      });
    })();

    // division codes updater
    (function() {
      var country  = $('#person_country')
        , division = $('#person_division')
        ;

      var setDivisionOptions = function(country_code, division_code) {
        if (typeof division_code === "undefined") {
          division_code = null;
        }
        $.ajax({
          dataType: 'json',
          url:      '/countries/' +
            encodeURIComponent(country_code) + '/divisions.json'
        })
        .fail(function() {
          division.empty();
          division.html('<option value="">---</option>');
          country.val('');
          alert("Sorry, please retry :'(");
        })
        .done(function(data) {
          division.empty();
          data.unshift({name: '---', code: ''});
          $(data).each(function(key, value) {
            var code = $('<div/>').text(value.code).html()
              , name = $('<div/>').text(value.name).html()
              ;
            division.append(
              '<option value="' + code + '">' + name + '</option>'
            );
          });
          if (division_code) {
            division.val(division_code).prop('selected', true);
          }
          return true;
        });
      };
      var country_code  = country.val()
        , division_code = division.val()
        ;

      // initialize
      if (country_code) {
        setDivisionOptions(country_code, division_code);
      }

      country.change(function() {
        var country_code = $(this).val(); // refetch
        if (country_code == '') {
          division.empty();
          division.html('<option value="">---</option>');
          return true;
        }
        return setDivisionOptions(country_code);
      });
    })();
  });
})(jQuery);
