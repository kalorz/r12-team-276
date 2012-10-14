Zepto(function ($) {
  var timeout, submit, loginChanged;

  submit = function () {
    var url     = '/?' + $('#login-form').serialize();
    var spinner = new Spinner().spin(document.getElementById('content'));

    $.get(url, function (data, status, xhr) {
      $('#badge').html(data);
      spinner.stop();
      delete spinner;
      $('.clippy').clippy();
    });
  }

  loginChanged = function () {
    if (this.value == $(this).data('current-value'))
      return false;

    $(this).data('current-value', this.value);

    if (timeout !== null) {
      clearTimeout(timeout);
    }

    timeout = setTimeout(submit, 666);
  }

  $('#login-form button').hide();
  $('#login').on('input keyup change', loginChanged);
  $('.clippy').clippy();

});
