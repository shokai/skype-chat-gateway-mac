module SkypeGateway
  class Skype
    class Message
      attr_reader :id, :user, :body, :time

      def initialize(id)
        @id = id
        @user = Skype.exec("GET CHATMESSAGE #{id} from_handle").split(/ /).last
        @body = Skype.exec("GET CHATMESSAGE #{id} body").gsub(/^MESSAGE \d+ BODY /i,'')
        @time = Time.at Skype.exec("GET CHATMESSAGE #{id} timestamp").split(/ /).last.to_i
      end

      def to_hash
        {
          :id => id,
          :user => user,
          :body => body,
          :time => time
        }        
      end

      def to_json(*a)
        to_hash.to_json(*a)
      end
    end

  end
end
