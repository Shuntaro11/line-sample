$(function(){
  
  function newmessage(message){
    var newmessage_same_part = `<div class="my-message">
                          <div class="message-detail" data-message-id=${message.id}>
                            <div class="message-detail__user-name">
                              ${message.user_name}
                            </div>
                            <div class="message-detail__date">
                              ${message.created_at}
                            </div>
                          </div>
                          <div class="my-message-main">` 
    if (message.content && message.image) {
      var html = newmessage_same_part +
                            `<p class="message-main__content">
                              ${message.content}
                            </p>
                            <img src="${message.image}" class="message__image" >
                          </div>
                        </div>`
    } else if (message.content) {
      var html = newmessage_same_part +
                            `<p class="message-main__content">
                              ${message.content}
                            </p>
                          </div>
                        </div>`
    } else if (message.image) {
      var html = newmessage_same_part +
                            `<img src="${message.image}" class="message__image" >
                          </div>
                        </div>`
    };
    return html;
  };
  function friendmessage(message){
    var friendmessage_same_part_upper = `<div class="message">
                                          <div class="user-image">
                                            <img src="${message.user_image}" class="image" >
                                          </div>` 
    var friendmessage_same_part_lower =   `<div class="message-detail" data-message-id=${message.id}>
                                            <div class="message-detail__user-name">
                                              ${message.user_name}
                                            </div>
                                            <div class="message-detail__date">
                                              ${message.created_at}
                                            </div>
                                          </div>
                                        </div>`
                                
    if (message.content && message.image) {
      var html = friendmessage_same_part_upper +`<div class="message-main">
                                            <p class="message-main__content">
                                              ${message.content}
                                            </p>
                                            <img src="${message.image}" class="message__image" >
                                            </div>`
                                          + friendmessage_same_part_lower
    } else if (message.content) {
      var html = friendmessage_same_part_upper +`<div class="message-main">
                                            <p class="message-main__content">
                                              ${message.content}
                                            </p>
                                            </div>`
                                          + friendmessage_same_part_lower
    } else if (message.image) {
      var html = friendmessage_same_part_upper +`<div class="message-main">
                                            <img src="${message.image}" class="message__image" >
                                            </div>`
                                          + friendmessage_same_part_lower
    };
    return html;
  };

  $('#new_groupmessage').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = newmessage(data);
      $('.message-list').append(html);
      $('.postboard').animate({ scrollTop: $('.postboard')[0].scrollHeight});
      $('.new-message')[0].reset();
      $('.form__submit').prop('disabled', false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  });

  var reloadMessages = function() {
    last_message_id = $('.message-detail:last').data("message-id");
    $.ajax({
      url: "api/groupmessages",
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      console.log(messages);
      if (messages.length !== 0) {
        var insertHTML = '';
        $.each(messages, function(i, message) {
          insertHTML += friendmessage(message)
        });
        $('.message-list').append(insertHTML);
        $('.postboard').animate({ scrollTop: $('.postboard')[0].scrollHeight});
      }
    })
    .fail(function() {
      alert("メッセージの読み込みに失敗しました");
    });
  };

  if (document.location.href.match(/\/groups\/\d+\/groupmessages/)) {
    setInterval(reloadMessages, 5000);
  }

});