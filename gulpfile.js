var sys = require('sys');

var gulp  = require('gulp')
  , bower = require('gulp-bower')
  , watch = require('gulp-watch')
  , shell = require('gulp-shell')
  ;
var sequence = require('run-sequence')
  ;

gulp.task('watch', function() {
  return watch('./test/**/*_test.rb', {
    read:          false
  , readDelay:     5
  , ignoreInitial: true
  , events:        ['add', 'change']
  }, function(file) {
    sys.puts('--');
    sys.puts('[' + file.event + ']');
    sys.puts(file.path);
  })
  .pipe(shell([
    'bundle exec foreman run ruby -I.:test <%= file.path %>'
  ]));
});

gulp.task('bower', function() {
  // see also .bowerrc
  return bower('./vendor/assets/components');
});

gulp.task('build-purecss', function() {
  process.chdir('./vendor/assets/components/purecss');
  return gulp.src('*')
    .pipe(shell([
      'npm install'
    , 'grunt'
    ]));
});

gulp.task('default', function(callback) {
  sequence('bower', 'build-purecss', callback);
});
