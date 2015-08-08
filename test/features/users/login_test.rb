require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def test_signin_as_owner
    team = locker_room_teams(:playing_piano)
    within_subdomain(team.subdomain) do
      visit(locker_room.login_url)
      assert_equal(locker_room.login_url, page.current_url)
      fill_in("Email",   :with => team.owners.first.email)
      fill_in("Password",:with => "secret")
      click_button("Signin")
      assert_content("You are now signed in.")
      assert_equal(locker_room.root_url, page.current_url)
      logout_user(locker_room.logout_url, :delete)
    end
  end

  def test_signin_as_user
    user = locker_room_users(:weenie)
    within_subdomain(user.team.subdomain) do
      visit(locker_room.login_url)
      assert_equal(locker_room.login_url, page.current_url)
      fill_in("Email",   :with => user.email)
      fill_in("Password",:with => "secret")
      click_button("Signin")
      assert_content("You are now signed in.")
      assert_equal(root_url, page.current_url)
      logout_user(locker_room.logout_url, :delete)
    end
  end
end
