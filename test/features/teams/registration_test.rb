require "test_helper"

class TeamRegistrationTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def test_subdomain_uniqueness_ensuring
    penguin = locker_room_teams(:penguin_patrol)

    visit "/"
    click_link("GET STARTED")
    find(:id, "team_name").set("Penguin Octupus Patrol")
    fill_in("Subdomain", :with => "penguin")
    fill_in("Username",  :with => "oswald")
    find(:id, "team_owners_attributes_0_name").set("Oswald")
    fill_in("Email",                 :with => "oswald@example.com")
    fill_in("Password",              :with => "ohmygosh", :exact => true)
    fill_in("Password confirmation", :with => "ohmygosh")
    click_button("Create Team")
    assert_equal("http://example.org/signup", page.current_url)
    assert_content("Your team could not be created.")
    assert_content("Subdomain has already been taken")
  end

  def test_subdomain_restriction_with_reserved_word
    visit "/"
    click_link("GET STARTED")
    find(:id, "team_name").set("Vanilla dog biscuits")
    fill_in("Subdomain", :with => "admin")
    fill_in("Username",  :with => "weenie")
    find(:id, "team_owners_attributes_0_name").set("Weenie")
    fill_in("Email",                 :with => "weenie@example.com")
    fill_in("Password",              :with => "bowwow", :exact => true)
    fill_in("Password confirmation", :with => "bowwow")
    click_button("Create Team")
    assert_equal("http://example.org/signup", page.current_url)
    assert_content("Your team could not be created.")
    assert_content("Subdomain admin is not allowed")
  end

  def test_subdomain_restriction_with_invalid_word
    visit "/"
    click_link("GET STARTED")
    find(:id, "team_name").set("Vanilla dog biscuits")
    fill_in("Subdomain", :with => "<test>")
    fill_in("Username",  :with => "weenie")
    find(:id, "team_owners_attributes_0_name").set("Weenie")
    fill_in("Email",                 :with => "weenie@example.com")
    fill_in("Password",              :with => "bowwow", :exact => true)
    fill_in("Password confirmation", :with => "bowwow")
    click_button("Create Team")
    assert_equal("http://example.org/signup", page.current_url)
    assert_content("Your team could not be created.")
    assert_content("Subdomain <test> is not allowed")
  end

  def test_team_registration
    visit "/"
    click_link("GET STARTED")
    find(:id, "team_name").set("Vanilla dog biscuits")
    fill_in("Subdomain", :with => "vanilla-dog-biscuits")
    fill_in("Username",  :with => "weenie")
    find(:id, "team_owners_attributes_0_name").set("Weenie")
    fill_in("Email",                 :with => "weenie@example.com")
    fill_in("Password",              :with => "bowwow", :exact => true)
    fill_in("Password confirmation", :with => "bowwow")
    click_button("Create Team")
    assert_equal("http://vanilla-dog-biscuits.example.org/", page.current_url)
    assert_content("Your team has been successfully created.")
    assert_content("Signed in as weenie@example.com")
    logout_user
  end
end
