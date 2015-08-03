icons = YAML.load_file("#{Rails.root}/config/icons.yml")
Rails.application.config.icons = icons
