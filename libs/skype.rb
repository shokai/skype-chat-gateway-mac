require 'rb-skypemac'

module SkypeGateway
  class Skype

    private
    def self.exec(command)
      SkypeMac::Skype.send_(:command => command)
    end
  
    public
    def self.recent_chats
      exec("SEARCH RECENTCHATS").split(/,* /).reject{|i|
        i !~ /^#.+\/.+/
      }
    end

    def self.send_message(to,body)
      exec "MESSAGE #{to} #{body}"
    end

    def self.send_chat_message(to,body)
      exec "chatmessage #{to} #{body}"
    end

    def self.message_ids(chat_id)
      exec("GET CHAT #{chat_id} RECENTCHATMESSAGES").
        split(/,* /).
        reject{|i|
        i !~ /^\d+$/
      }.map{|i|
        i.to_i
      }.sort.reverse
    end

    def self.message(id)
      Message.new id
    end
  end

end
