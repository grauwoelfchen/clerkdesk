# LibreCash

[![Code Climate](https://codeclimate.com/github/grauwoelfchen/librecash/badges/gpa.svg)](
https://codeclimate.com/github/grauwoelfchen/librecash)
[![Test Coverage](https://codeclimate.com/github/grauwoelfchen/librecash/badges/coverage.svg)](
https://codeclimate.com/github/grauwoelfchen/librecash/coverage)
[![Managed with Taiga.io](https://img.shields.io/badge/managed%20with-TAIGA.io-709f14.svg)](
https://tree.taiga.io/project/grauwoelfchen-librecash/ "Managed with Taiga.io")

![LibreCash](
https://gitlab.com/librecash/librecash/raw/master/app/assets/images/librecash-logo-140x24.png)

## Development

### Setup

* Ruby `2.4.1`
  * Rails `5.1.0`
  * Bundler `1.13.7`
* JavaScript
  * Node.js `7.9.0`
  * npm `4.5.0`
* PostgreSQL `9.6`

```zsh
% ruby --version
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-linux]
```

```zsh
: e.g. Setup Node.js via nodeenv
% python3.5 -m venv venv
% source venv/bin/activate

(venv) % pip install --upgrade setuptools pip
(venv) % pip install nodeenv
(venv) % nodeenv --node=7.9.0 -p
(venv) % source venv/bin/activate
(venv) % node --version
v7.9.0
(venv) % npm install --upgrade npm
4.5.0
```

### Dependencies

```zsh
: rubygems
(venv) % gem install bundler --version=1.13.7
(venv) % bundle install --path .bundle/gems
```

```zsh
: npm packages (see also `gulpfile.js`)
(venv) % npm install -g gulp-cli eslint
(venv) % npm install

(venv) % gulp
```

### Database

```zsh
: make .env
(venv) % cp .env.sample .env

(venv) % bundle exec foreman run rake db:migrate
(venv) % bundle exec foreman run rake db:seed
```

### Boot

```zsh
: use run or foreman start
(venv) % bundle exec foreman run devel
```

See `Procfile`

### Test

```zsh
: run test suite
(venv) % bundle exec foreman run test

: Run single test file
(venv) % bundle exec foreman run ruby -I.:test test/models/note_test.rb
```

## License

Copyright (C) 2015-2017 Yasuhiro Asaka

This is free software;  
You can redistribute it and/or modify it under the terms of
the GNU Affero General Public License (AGPL).

See doc/LICENSE.
