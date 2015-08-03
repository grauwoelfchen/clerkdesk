# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  jquery-autosize/jquery.autosize.min.js
  jquery-ui/jquery-ui.min.js
  jquery-ui/ui/minified/autocomplete.min.js
  jquery-tag-editor/jquery.caret.min.js
  jquery-tag-editor/jquery.tag-editor.min.js
  jquery-selectric/public/jquery.selectric.min.js
  jquery-selectric/public/selectric.css
  autoNumeric/autoNumeric.js
  pickmeup/js/jquery.pickmeup.min.js
  chosen/chosen.jquery.min.js
  chosen/chosen.min.css
)
