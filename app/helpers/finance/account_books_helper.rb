module Finance
  module AccountBooksHelper
    def account_book_icons
      Rails.application.config.icons.to_a
    end
  end
end
