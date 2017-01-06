# LibreCash

[![Code Climate](https://codeclimate.com/github/grauwoelfchen/librecash/badges/gpa.svg)](https://codeclimate.com/github/grauwoelfchen/librecash)
[![Test Coverage](https://codeclimate.com/github/grauwoelfchen/librecash/badges/coverage.svg)](https://codeclimate.com/github/grauwoelfchen/librecash/coverage)

[Project on TAIGA](https://tree.taiga.io/project/grauwoelfchen-librecash/)

![LibreCash](https://raw.githubusercontent.com/grauwoelfchen/librecash/master/app/assets/images/librecash-logo-140x24.png)

## Development

### Setup

* Ruby
* JavaScript (Node.js)

```zsh
% ruby --version
ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]
```

```zsh
: e.g. Setup Node.js via nodeenv
% python3.4 -m venv venv
% source venv/bin/activate

(venv) % pip install --upgrade setuptools pip
(venv) % pip install nodeenv
(venv) % nodeenv --node=6.9.4 -p
(venv) % source venv/bin/activate
(venv) % node --version
v6.9.4
```

### Dependencies

```zsh
: rubygems
(venv) % gem install bundler
(venv) % bundle install --path .bundle/gems
```

```zsh
: npm packages (see also `gulpfile.js`)
(venv) % npm install
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
You can redistribute it and/or modify it under the terms of the GNU Affero General Public License (AGPL).

See doc/LICENSE.
