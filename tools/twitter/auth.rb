#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'oauth'
require 'yaml'

conf_file = File.dirname(__FILE__) + '/config.yaml'

begin
  conf = YAML::load open(conf_file)
rescue
  STDERR.puts 'config.yaml load error'
  exit 1
end

consumer = OAuth::Consumer.new(conf['consumer_key'], conf['consumer_secret'],
                               :site => "http://twitter.com/")

request_token = consumer.get_request_token(
                                           #:oauth_callback => "http://example.com"
                                           )

puts 'please access following URL and approve'
puts request_token.authorize_url

print 'then, input OAuth Verifier: '
oauth_verifier = gets.chomp.strip

access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)

conf['access_token'] = access_token.token
conf['access_secret'] = access_token.secret

open(conf_file, 'w+'){|f|
  f.write conf.to_yaml
}
