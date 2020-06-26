$(function() {

  $(".User__numbers--followings").on('click', function() {
    $("#followings-overlay").css('display', 'block');
    $("#followings-modalWindow").css('display', 'block');
  });
  $("#followings-overlay").on('click', function() {
    $('#followings-overlay').fadeOut();
    $('#followings-modalWindow').fadeOut();
  });

  $(".User__numbers--followers").on('click', function() {
    $("#followers-overlay").css('display', 'block');
    $("#followers-modalWindow").css('display', 'block');
  });
  $("#followers-overlay").on('click', function() {
    $('#followers-overlay').fadeOut();
    $('#followers-modalWindow').fadeOut();
  });
});
