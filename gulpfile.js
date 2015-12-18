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
  , readDelay:     1
  , ignoreInitial: true
  , events:        ['add', 'change']
  }, function(file) {
    console.log('--');
    console.log('[' + file.event + ']');
    console.log(file.path);
  })
  .pipe(shell([
    'bundle exec foreman run ruby -I.:test <%= file.path %>'
  ]));
});

gulp.task('bower', function() {
  // see also .bowerrc
  return bower('./vendor/assets/components');
});

gulp.task('default', function(callback) {
  return sequence('bower', callback);
});
