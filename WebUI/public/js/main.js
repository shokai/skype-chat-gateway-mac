var KC = {tab:9, enter:13, left:37, up:38, right:39, down:40};

String.prototype.htmlMarkup = function(){
        return this.replace(/(https?:\/\/[^\s]+)/gi,'<a href="$1">$1</a>')
}


String.prototype.htmlEscape = function(){
    var span = document.createElement('span');
    var txt =  document.createTextNode('');
    span.appendChild(txt);
    txt.data = this;
    return span.innerHTML;
};

$(function(){
      $('input#btn_send').click(chat.post);
      $('input#body').keydown(
          function(e){
              if(e.keyCode == KC.enter){
                  chat.post();
              }
          }
      );
      chat.get();
      setInterval(chat.get, chat_interval);
      var name = $.cookie('name');
      if(name != null && name.length > 0) $('input#name').val(name);
});

var chat = {};

chat.post = function(){
    var name = $('input#name').val();
    var body = $('input#body').val();
    if(name.length < 1 || body.length < 1) return;
    $.cookie('name', name);
    $.ajax(
        {
            url : app_root + '/chat.json',
            data : {
                name : name, body : body
            },
            error : function(e){
                alert('post error : '+body);
            },
            complete : function(e){
                $('input#body').val('');
            },
            type : 'POST',
            dataType : 'json'
        }
    );
};

chat.get = function(){
    $.ajax(
        {
            url : app_root + '/chat.json',
            success : function(data){
                chatData.merge(data);
                chatData.display();
            },
            type : 'GET',
            dataType : 'json'
        }
    );
};

var chatData = {};
chatData.data = {};
chatData.merge = function(data){
    for(i in data){
        var c = data[i];
        this.data[c.id] = c;
    }
};

chatData.display = function(){
    var tl = $('ul#timeline');
    tl.html('');
    for(i in this.data){
        var c = this.data[i];
        var line = (''+c.user+'> '+c.body+' - '+new Date(c.time*1000)).htmlEscape().htmlMarkup();
        var li = $('<li>').html(line);
        tl.prepend(li);
    }
};