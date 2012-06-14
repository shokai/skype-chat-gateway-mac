module SkypeGateway
  class HttpServer  < EM::Connection
    include EM::HttpServer

    def self.chats=(hash)
      @@chats = hash
    end
    
    def process_http_request
      res = EM::DelegatedHttpResponse.new(self)
      puts "* #{@http_request_method} #{@http_path_info} #{@http_query_string} #{@http_post_content}"
      case @http_path_info
      when '/chats'
        res.content = @@chats.to_json
        res.status = 200
      when /^\/message\/(.+)/
        to = @http_path_info.scan(/\/message\/(.+)/)[0][0]
        res.content = Skype.send_message to, @http_post_content
        res.status = 200
      when /^\/chat\/(.+)/
        chat_id = @@chats[@http_path_info.scan(/\/chat\/(.+)/)[0][0]]
        case @http_request_method
        when 'POST'
          res.content = Skype.send_chat_message(chat_id, @http_post_content)
          res.status = 200
        when 'GET'
          res.content = Skype.message_ids(chat_id)[0...200].map{|id|
            TmpCache.get(id) || TmpCache.set(id, Skype.message(id), 1200)
          }.to_json
          res.status = 200
        end
      else
        res.content = 'nof found'
        res.status = 404
      end
      res.send_response
    end
  end
end
