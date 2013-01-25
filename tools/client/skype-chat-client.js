if(process.argv.length < 3){
  console.error(process.argv[0]+' '+process.argv[1]+' http://localhost:8787/chat/CHAT_NAME');
  process.exit(1);
}

var gateway = process.argv[2];

var _ = require('underscore');
var request = require('request');

var Skype = function(addr){
  var self = this;
  this.addr = addr;
  this.last_message_id = 0;

  this.get = function(callback, errback){
    request.get(self.addr,function(err, res, body){
      if(err || res.statusCode != 200){
        if(typeof errback == 'function') errback(res.statusCode);
        return;
      }
      try{
        var chats = JSON.parse(body).reverse();
      }
      catch(e){
        if(typeof errback === 'function') errback(e);
        return;
      }
      if(typeof callback === 'function'){
        _.each(chats, function(message){
          if(self.last_message_id < message.id){
            self.last_message_id = message.id;
            callback(message);
          }
        });
      }
    });
  };
  this.post = function(message, callback, errback){
    request.post({url: self.addr, body: message}, function(err, res, body){
      if(err || res.statusCode != 200){
        if(typeof errback === 'function') errback(body);
        return;
      }
      if(typeof callback === 'function') callback(body);
    });
  };
};

var skype = new Skype(gateway);
console.log(skype.addr);

setInterval(function(){
  skype.get(function(chat){
    console.log(chat.user+': '+chat.body);
  }, function(stat){
    console.error(stat);
  });
}, 5000);

process.stdin.resume();
process.stdin.setEncoding('utf8');

process.stdin.on('data', function(lines){
  _.each(lines.trim().split(/[\r\n]/), function(line){
    console.log('send '+line);
    skype.post(line, function(res){
      console.log(res);
    }, function(err){
      console.error(err);
    });
  });
});
