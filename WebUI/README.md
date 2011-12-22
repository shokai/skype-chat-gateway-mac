Skype Web UI
============
Skype Chat Gateway WebUI

* Ruby 1.8.7+
* Sinatra 1.3+

Install Dependencies
--------------------

    % gem install bundler
    % bundle install


Config
------

    % cp sample.config.yaml config.yaml

edit it.


Run
---

    % ruby development.ru

open [http://localhost:8080](http://localhost:8080)


Deploy
------
use Passenger with "config.ru"
