$(function() {

  let search_list = $(".modalWindow__result");

  function appendUser(user) {
    let html =
      `<div class"modalWindow__result--name">
        <a href="/users/${user.id}"><img src="${user.image}" class="UserInfoShow-image--searched"></a>
        <a class="UserInfoShow-name--searched", href="/users/${user.id}">${user.name}</a>
      </div>`
    search_list.append(html);
  }

  function appendErrMsgToHTML(msg) {
    let html =
    `<div class"modalWindow__result--name">
      ${msg}
    </div>`
    search_list.append(html);
  }

  $(".Form__inputName").on("keyup", function() {
    let input = $(".Form__inputName").val();
    $('.modalWindow__result').empty();
    $.ajax({
      url: '/posts/search',
      type: 'GET',
      dataType: 'json',
      data: {keyword: input}
    })
    .done(function(users) {
      $("#modalWindow").css('display', 'block');
      $("#overlay").css('display', 'block');
      if (users.length !== 0) {
        users.forEach(function(user){
          appendUser(user);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        appendErrMsgToHTML("ユーザーが見つかりません");
      }
    })
    .fail(function() {
      console.log("error");
    })
  });

  $(".PostPic__trash").on('click', function(){
    $("#postShow-modalWindow").css('display', 'block');
    $("#postShow-overlay").css('display', 'block');
  })

  $("#overlay").on('click', function() {
    $('#overlay').fadeOut();
    $('#modalWindow').fadeOut();
  });

  $("#postShow-overlay").on('click', function() {
    $('#postShow-overlay').fadeOut();
    $('#postShow-modalWindow').fadeOut();
  });

  $(".modal-PostPic__back").on('click', function() {
    $('#postShow-overlay').fadeOut();
    $('#postShow-modalWindow').fadeOut();
  });

});
