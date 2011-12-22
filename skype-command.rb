#!/usr/bin/env ruby
require 'rubygems'
require 'rb-skypemac'

def skype(command)
  SkypeMac::Skype.send_(:command => command)
end

p skype ARGV.join(' ')
