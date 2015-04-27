# Cleckdesk


## Setup

* Ruby
* Node.js

```
;; e.g. Setup Node.js via Python's virtualenv
% virtualenv venv
(venv) % pip install nodeenv
(venv) % nodeenv -p
```

```
;; Install bundler
(venv) % gem install bundler

;; Install rubygems via bundler
(venv) % bundle install --path .bundle/gems

;; Install npm packages
(venv) % npm install

;; Install gulp
(venv) % npm install gulp -g

;; Install asset packages via gulp
(venv) % gulp bower
```

see also `.bowerrc` and `bower.json`


## Boot

```
(venv) % bundle exec foreman run server
```

see `Procfile`


## Test

```
;; Run test suit
(venv) % bundle exec foreman run rake test

;; Run test only for specified file
(venv) % bundle exec foreman run ruby -I.:test test/models/note_test.rb

;; Watch with gulp (see gulpfile.js)
(venv) % gulp watch
```


## Document

![ER diagram](https://github.com/grauwoelfchen/clerkdesk/raw/master/doc/er.png)
