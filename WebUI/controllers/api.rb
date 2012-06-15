
before '/*.json' do
  content_type 'application/json'
end

get '/chat.json' do
  uri = URI.parse Conf['gateway']
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
  uri = URI.parse Conf['gateway']
  res = nil
  Net::HTTP.start(uri.host, uri.port) do |http|
    res = http.post(uri.path, "<#{@name}> #{@body}")
  end
  status 200
  @mes = {:api => res.body}.to_json
end
