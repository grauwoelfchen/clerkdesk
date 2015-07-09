require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :memberships)

  #def test_validation_at_signin_attempt_as_owner_with_invalid_email
  #  team = locker_room_teams(:playing_piano)
  #  within_subdomain(team.subdomain) do
  #    visit(locker_room.login_url)
  #    assert_content("Please signin.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    fill_in("Email",   :with => "henry@example.org")
  #    fill_in("Password",:with => "ohmygosh")
  #    click_button("Signin")
  #    assert_content("Email or password is invalid.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    logout_user(locker_room.logout_url, :delete)
  #  end
  #end

  #def test_validation_at_signin_attempt_as_owner_with_invalid_password
  #  team = locker_room_teams(:playing_piano)
  #  within_subdomain(team.subdomain) do
  #    visit(locker_room.login_url)
  #    assert_content("Please signin.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    fill_in("Email",   :with => team.owners.first.email)
  #    fill_in("Password",:with => "weenie-girl")
  #    click_button("Signin")
  #    assert_content("Email or password is invalid.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    logout_user(locker_room.logout_url, :delete)
  #  end
  #end

  #def test_validation_at_signin_attempt_as_owner_with_other_subdomain
  #  team       = locker_room_teams(:penguin_patrol)
  #  other_team = locker_room_teams(:playing_piano)
  #  within_subdomain(other_team.subdomain) do
  #    visit(locker_room.root_url)
  #    assert_content("Please signin.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    fill_in("Email",   :with => team.owners.first.email)
  #    fill_in("Password",:with => "nomorenoless")
  #    click_button("Signin")
  #    assert_content("Email or password is invalid.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    logout_user(locker_room.logout_url, :delete)
  #  end
  #end

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

  #def test_validation_at_signin_attempt_as_member_with_invalid_email
  #  user = locker_room_users(:weenie)
  #  within_subdomain(user.team.subdomain) do
  #    visit(locker_room.login_url)
  #    assert_content("Please signin.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    fill_in("Email",   :with => "henry@example.org")
  #    fill_in("Password",:with => "bowwow")
  #    click_button("Signin")
  #    assert_content("Email or password is invalid.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    logout_user(locker_room.logout_url, :delete)
  #  end
  #end

  #def test_validation_at_signin_attempt_as_member_with_invalid_password
  #  user = locker_room_users(:weenie)
  #  within_subdomain(user.team.subdomain) do
  #    visit(locker_room.login_url)
  #    assert_content("Please signin.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    fill_in("Email",   :with => user.email)
  #    fill_in("Password",:with => "woof")
  #    click_button("Signin")
  #    assert_content("Email or password is invalid.")
  #    assert_equal(locker_room.login_url, page.current_url)
  #    logout_user(locker_room.logout_url, :delete)
  #  end
  #end

  def test_signin_as_member
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
