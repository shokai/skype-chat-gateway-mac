
before '/*.json' do
  content_type 'application/json'
end

before '/*' do
  @title = @@conf['title']
end

get '/' do
  haml :index
end

get '/api' do
  haml :api
end

get '/chat.json' do
  uri = URI.parse @@conf['gateway']
  res = nil
  Net::HTTP.start(uri.host, uri.port) do |http|
    res = http.get(uri.path)
  end
  status 200
  @mes = res.body
end

post '/chat.json' do
  @name = params['name']
  @body = params['body']
  uri = URI.parse @@conf['gateway']
  res = nil
  Net::HTTP.start(uri.host, uri.port) do |http|
    res = http.post(uri.path, "<#{@name}> #{@body}")
  end
  status 200
  @mes = {:api => res.body}.to_json
end
