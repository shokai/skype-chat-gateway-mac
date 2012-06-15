
before '/*' do
  @title = Conf['title']
end

get '/' do
  haml :index
end

get '/api' do
  haml :api
end
