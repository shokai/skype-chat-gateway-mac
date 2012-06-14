Skype Chat Gateway for Mac
==========================
Skype Chat <--(HTTP)--> Your Apps

Skype API
---------
https://developer.skype.com/public-api-reference-index

* Ruby 1.8.7
* Mac OSX


Install Dependencies
--------------------

    % gem install bundler
    % bundle install

Run
---

    % ruby skype-chat-gateway --help
    % ruby skype-chat-gateway --list
    % ruby skype-chat-gateway --port 8787


HTTP Interface
--------------

post message

    % curl -d 'hello skype gateway' http://localhost:8787/message/user_name
    % curl -d 'hello skype gateway' http://localhost:8787/chat/chat_alias


get recent chat messages

    % curl http://localhost:8787/chat/chat_alias


get chat list

    % curl http://localhost:8787/chats


Auto Start
----------

install plist

    % mkdir ~/Library/LaunchAgents
    % cp org.shokai.skypegateway.plist ~/Library/LaunchAgents/

edit plist, then

    % launchctl load -w ~/Library/LaunchAgents/org.shokai.skypegateway.plist


LICENSE:
========

(The MIT License)

Copyright (c) 2011 Sho Hashimoto

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
