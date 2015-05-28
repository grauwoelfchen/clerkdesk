(function($) {
  'use strict';
  $(function() {
    var subdivision = $('#person_state');

    $(subdivision).parent().append('<span id="indicator"><img src="/assets/loading.gif"></div>');
    $('#indicator').css({
      display: 'none',
      margin:  '7px 0 2px 0',
      padding: '0',
      'vertical-align': 'middle'
    });

    $(document).ajaxStart(function() {
      subdivision.hide();
      $('#indicator').css({display: 'inline-block'});
    }).ajaxStop(function() {
      $('#indicator').hide();
      subdivision.show();
    });

    var setSubdivisionOptions = function(country_code) {
      $.ajax({
        url: '/countries/' +
          encodeURIComponent(country_code) + '/subdivisions.json',
        dataType: 'json'
      })
      .fail(function() {
        subdivision.empty();
        subdivision.html('<option value="">---</option>');
        $('#person_country').val('');
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
        return true;
      });
    };

    var country_code = $('#person_country').val();
    if (country_code) {
      setSubdivisionOptions(country_code);
    }

    $('#person_country').change(function() {
      var country_code = $(this).val()
        , subdivision  = $('#person_state')
        ;
      if (country_code == '') {
        subdivision.empty();
        subdivision.html('<option value="">---</option>');
        return true;
      }
      return setSubdivisionOptions(country_code);
    });
  });
})(jQuery);
