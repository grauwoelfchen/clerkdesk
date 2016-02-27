# LibreCash

[![Codeship Status for grauwoelfchen/librecash](https://codeship.com/projects/b811c880-e27b-0132-f70e-4ea0dd54b93d/status?branch=master)](https://codeship.com/projects/81463)
[![Code Climate](https://codeclimate.com/github/grauwoelfchen/librecash/badges/gpa.svg)](https://codeclimate.com/github/grauwoelfchen/librecash)
[![Test Coverage](https://codeclimate.com/github/grauwoelfchen/librecash/badges/coverage.svg)](https://codeclimate.com/github/grauwoelfchen/librecash/coverage)

[Project on TAIGA](https://tree.taiga.io/project/grauwoelfchen-librecash/)

![LibreCash](https://raw.githubusercontent.com/grauwoelfchen/librecash/master/app/assets/images/librecash-logo-140x24.png)

## Development

### Setup

* Ruby
* Node.js

```
;; e.g. Setup Node.js
% node --version
v4.3.1
```

```
% ruby --version
ruby 2.2.4p230 (2015-12-16 revision 53155) [x86_64-linux]

;; Install rubygems
% gem install bundler
% bundle install --path .bundle/gems

;; Install npm packages and build assets
% npm install
```

see also: `gulpfile.js`, `bower.json`

### Boot

```
% bundle exec foreman run server
```

see `Procfile`

### Test

```
;; Run test
% bundle exec foreman run test
% bundle exec foreman run ruby -I.:test test/models/note_test.rb
```

## License

Copyright (C) 2015 Yasuhiro Asaka

This is free software;
You can redistribute it and/or modify it under the terms of the GNU Affero General Public License (AGPL).

See doc/LICENSE.
