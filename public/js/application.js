Zepto(function($) {
  var timeout, submit, loginChanged;

  submit = function() {
    var url = '/' + $('#login-form').serializeArray()['login'];

    $.get(url, function(data, status, xhr) {
      $('#badge').html(data);
    });
  }

  loginChanged = function() {
    if (timeout !== null) {
      clearTimeout(timeout);
    }

    timeout = setTimeout(submit, 1000);
  }

  $('#login-form button').hide();
  $('#login').on('change keyup', loginChanged);

});
