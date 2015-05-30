(function($) {
  'use strict';
  $(function() {
    var country     = $('#person_country')
      , subdivision = $('#person_state')
      ;

    // indicator
    $(subdivision).parent().append(
      '<span id="indicator"><img src="/assets/loading.gif"></div>'
    );
    $('#indicator').css({
      display:          'none',
      margin:           '7px 0 2px 0',
      padding:          '0',
      'vertical-align': 'middle'
    });
    $(document).ajaxStart(function() {
      subdivision.hide();
      $('#indicator').css({display: 'inline-block'});
    }).ajaxStop(function() {
      $('#indicator').hide();
      subdivision.show();
    });

    // subdivision codes updater
    var setSubdivisionOptions = function(country_code, subdivision_code) {
      if (typeof subdivision_code === "undefined") {
        subdivision_code = null;
      }
      $.ajax({
        dataType: 'json',
        url:      '/countries/' +
          encodeURIComponent(country_code) + '/subdivisions.json'
      })
      .fail(function() {
        subdivision.empty();
        subdivision.html('<option value="">---</option>');
        country.val('');
        alert("Sorry, please retry :'(");
      })
      .done(function(data) {
        subdivision.empty();
        data.unshift({name: '---', code: ''});
        $(data).each(function(key, value) {
          var code = $('<div />').text(value.code).html()
            , name = $('<div />').text(value.name).html()
            ;
          subdivision.append(
            '<option value="' + code + '">' + name + '</option>'
          );
        });
        if (subdivision_code) {
          subdivision.val(subdivision_code).prop('selected', true);
        }
        return true;
      });
    };

    var country_code     = country.val()
      , subdivision_code = subdivision.val()
      ;

    // initialize
    if (country_code) {
      setSubdivisionOptions(country_code, subdivision_code);
    }

    country.change(function() {
      var country_code = $(this).val(); // refetch
      if (country_code == '') {
        subdivision.empty();
        subdivision.html('<option value="">---</option>');
        return true;
      }
      return setSubdivisionOptions(country_code);
    });
  });
})(jQuery);
