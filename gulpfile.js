var gulp  = require('gulp')
  , bower = require('gulp-bower')
  ;

gulp.task('bower', function() {
  // see also .bowerrc
  return bower('./vendor/assets/components');
});

gulp.task('default', ['bower']);
