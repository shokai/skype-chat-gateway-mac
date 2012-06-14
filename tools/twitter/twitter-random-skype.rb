#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'oauth'
require 'json'
require 'uri'
require 'net/http'
require 'backports'

begin
  conf = YAML::load open(File.dirname(__FILE__) + '/config.yml')
rescue => e
  STDERR.puts e
  STDERR.puts 'config.yml load error'
  exit 1
end

api = ARGV.first
unless api =~ /^https?:\/\/+/
  puts "ruby #{$0} http://localhost:8787/"
  exit 1
end

Twitter.configure do |config|
  config.consumer_key = conf['consumer_key']
  config.consumer_secret = conf['consumer_secret']
  config.oauth_token = conf['access_token']
  config.oauth_token_secret = conf['access_secret']
end

m = Twitter.home_timeline.delete_if{|i|
  i.user.screen_name == Twitter.user.screen_name
}.sample

puts msg = "@#{m.user.screen_name} : #{m.text}\nhttp://twitter.com/#{m.user.screen_name}/status/#{m.id}"

uri = URI.parse api
Net::HTTP.start(uri.host, uri.port) do |http|
  http.post(uri.path.size > 0 ? uri.path : '/', msg)
end
