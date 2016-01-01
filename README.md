# Cleckdesk

[![Codeship Status for grauwoelfchen/clerkdesk](https://codeship.com/projects/b811c880-e27b-0132-f70e-4ea0dd54b93d/status?branch=master)](https://codeship.com/projects/81463)

[Project on TAIGA](https://tree.taiga.io/project/grauwoelfchen-clerkdesk/)


## Development

### Setup

* Ruby
* Node.js

```
;; e.g. Setup Node.js via Python's virtualenv
% virtualenv venv
(develp) % pip install nodeenv
(develp) % nodeenv env --node=4.2.3
(develp) % deactivate
% source env/bin/activate
(env) % node --version
v4.2.3
```

```
;; Install rubygems and npm packages
(env) % gem install bundler
(env) % bundle install --path .bundle/gems
(env) % npm install
(env) % npm install gulp -g
(env) % gulp bower
```

see also `.bowerrc` and `bower.json`

### Boot

```
(env) % bundle exec foreman run server
```

see `Procfile`

### Test

```
;; Run test suit as you like
(env) % bundle exec foreman run test
(env) % bundle exec foreman run ruby -I.:test test/models/note_test.rb

;; Watch with gulp (see gulpfile.js)
(env) % gulp watch
```

## License

Copyright (C) 2015 Yasuhiro Asaka

This is free software; You can redistribute it and/or modify it under the terms of the GNU Affero General Public License (AGPL).  
See doc/LICENSE.
