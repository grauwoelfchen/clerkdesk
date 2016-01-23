require 'test_helper'

class UserLoginTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def test_signin_as_owner
    team = locker_room_teams(:playing_piano)
    user = team.primary_owner
    within_subdomain(team.subdomain) do
      visit(locker_room.login_url)
      assert_equal(locker_room.login_url, page.current_url)
      fill_in('Email',    :with => user.email)
      fill_in('Password', :with => 'secret')
      click_button('Signin')
      assert_content('You are now signed in.')
      assert_equal(locker_room.root_url, page.current_url)
      signout_user
    end
  end

  def test_signin_as_user
    user = locker_room_users(:weenie)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      visit(locker_room.login_url)
      assert_equal(locker_room.login_url, page.current_url)
      fill_in('Email',    :with => user.email)
      fill_in('Password', :with => 'secret')
      click_button('Signin')
      assert_content('You are now signed in.')
      assert_equal(locker_room.root_url, page.current_url)
      signout_user
    end
  end
end
