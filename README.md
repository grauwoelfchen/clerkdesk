# LibreCash

[![Codeship Status for grauwoelfchen/librecash](https://codeship.com/projects/b811c880-e27b-0132-f70e-4ea0dd54b93d/status?branch=master)](https://codeship.com/projects/81463)
[![Code Climate](https://codeclimate.com/github/grauwoelfchen/librecash/badges/gpa.svg)](https://codeclimate.com/github/grauwoelfchen/librecash)
[![Test Coverage](https://codeclimate.com/github/grauwoelfchen/librecash/badges/coverage.svg)](https://codeclimate.com/github/grauwoelfchen/librecash/coverage)

[Project on TAIGA](https://tree.taiga.io/project/grauwoelfchen-librecash/)

![LibreCash](https://raw.githubusercontent.com/grauwoelfchen/librecash/master/app/assets/images/librecash-logo-140x24.png)

## Development

### Setup

* Ruby
* JavaScript (Node.js)

```zsh
: e.g. Setup Node.js
% node --version
v6.3.1
```

```zsh
% ruby --version
ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]

: Install rubygems
% gem install bundler
% bundle install --path .bundle/gems

: Install npm packages and build assets
% npm install
```

See `gulpfile.js`, `bower.json`

### Prepare

```zsh
: Make .env
% cp .env.sample .env

: DB
% bundle exec foreman run rake db:migrate
% bundle exec foreman run rake db:seed
```

### Boot

```zsh
: Or use foreman start
% bundle exec foreman run devel
```

See `Procfile`

### Test

```zsh
: Run test suite
% bundle exec foreman run test

: Run single test file
% bundle exec foreman run ruby -I.:test test/models/note_test.rb
```

## License

Copyright (C) 2015 Yasuhiro Asaka

This is free software;
You can redistribute it and/or modify it under the terms of the GNU Affero General Public License (AGPL).

See doc/LICENSE.
