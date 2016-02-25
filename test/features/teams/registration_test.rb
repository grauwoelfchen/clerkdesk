require 'test_helper'

class TeamRegistrationTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def test_subdomain_uniqueness_ensuring
    penguin = locker_room_teams(:penguin_patrol)
    visit(locker_room.registration_url(subdomain: nil))
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    find(:id, 'team_name').set('Penguin Octupus Patrol')
    fill_in('Subdomain', :with => penguin.subdomain)
    fill_in('Username',  :with => 'oswald')
    find(:id, 'team_owners_attributes_0_name').set('Oswald')
    fill_in('Email',                 :with => 'oswald@example.com')
    fill_in('Password',              :with => 'ohmygosh', :exact => true)
    fill_in('Password confirmation', :with => 'ohmygosh')
    click_button('Create Team')
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    assert_content('Team could not be created.')
    assert_content('Subdomain has already been taken')
  end

  def test_subdomain_restriction_with_reserved_word
    visit(locker_room.registration_url(subdomain: nil))
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    find(:id, 'team_name').set('Vanilla dog biscuits')
    fill_in('Subdomain', :with => 'admin')
    fill_in('Username',  :with => 'weenie')
    find(:id, 'team_owners_attributes_0_name').set('Weenie')
    fill_in('Email',                 :with => 'weenie@example.com')
    fill_in('Password',              :with => 'bowwow', :exact => true)
    fill_in('Password confirmation', :with => 'bowwow')
    click_button('Create Team')
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    assert_content('Team could not be created.')
    assert_content('Subdomain admin is not allowed')
  end

  def test_subdomain_restriction_with_invalid_word
    visit(locker_room.registration_url(subdomain: nil))
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    find(:id, 'team_name').set('Vanilla dog biscuits')
    fill_in('Subdomain', :with => 'admin')
    fill_in('Username',  :with => 'weenie')
    find(:id, 'team_owners_attributes_0_name').set('Weenie')
    fill_in('Email',                 :with => 'weenie@example.com')
    fill_in('Password',              :with => 'bowwow', :exact => true)
    fill_in('Password confirmation', :with => 'bowwow')
    click_button('Create Team')
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    assert_content('Team could not be created.')
    assert_content('Subdomain admin is not allowed')
  end

  def test_subdomain_restriction_with_invalid_word
    visit(locker_room.registration_url(subdomain: nil))
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    find(:id, 'team_name').set('Vanilla dog biscuits')
    fill_in('Subdomain', :with => '<test>')
    fill_in('Username',  :with => 'weenie')
    find(:id, 'team_owners_attributes_0_name').set('Weenie')
    fill_in('Email',                 :with => 'weenie@example.com')
    fill_in('Password',              :with => 'bowwow', :exact => true)
    fill_in('Password confirmation', :with => 'bowwow')
    click_button('Create Team')
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    assert_content('Team could not be created.')
    assert_content('Subdomain <test> is not allowed')
  end

  def test_team_registration
    visit(locker_room.registration_url(subdomain: nil))
    assert_equal("http://#{RACK_HOST}/signup", page.current_url)
    find(:id, 'team_name').set('Lovely flowers')
    fill_in('Subdomain', :with => 'lovely-flowers')
    fill_in('Username',  :with => 'daisy')
    find(:id, 'team_owners_attributes_0_name').set('Daisy')
    fill_in('Email',                 :with => 'daisy@example.org')
    fill_in('Password',              :with => 'byebyuuun', :exact => true)
    fill_in('Password confirmation', :with => 'byebyuuun')
    click_button('Create Team')
    assert_equal("http://lovely-flowers.#{RACK_HOST}/", page.current_url)
    assert_content('Team has been successfully created.')
    within_subdomain('lovely-flowers') do
      signout_user
    end
  end
end
