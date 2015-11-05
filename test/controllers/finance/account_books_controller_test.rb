require 'test_helper'

module Finance
  class AccountBooksControllerTest < ActionController::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/reports', :'finance/account_books')

    def test_get_show
      user = locker_room_users(:oswald)
      team = user.teams.first
      within_subdomain(team.subdomain) do
        login_user(user)
        account_book = finance_account_books(:general_money)
        get(:show,
          :report_id => account_book.report_id, :id => account_book.id)
        assert_equal(account_book, assigns[:account_book])
        assert_equal(account_book.report, assigns[:report])
        assert_template(:show)
        assert_response(:success)
      end
    end
  end
end
