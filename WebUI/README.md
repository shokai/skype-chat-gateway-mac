Skype Web UI
============
Skype Chat Gateway WebUI

* Ruby 1.8.7+
* Sinatra 1.3+

<img src="http://shokai.org/archive/file/7064179199be6ab16f6f44d864fefa72.png">


Install Dependencies
--------------------

    % gem install foreman bundler
    % bundle install


Config
------

    % cp sample.config.yml config.yml

edit it.


Run
---

    % foreman start

=> http://localhost:5000


Deploy
------
use Passenger or Heroku.
