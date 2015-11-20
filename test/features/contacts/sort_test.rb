require 'test_helper'

class ContactSortTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:contacts)

  def test_sort_with_name_desc
    user = locker_room_users(:weenie)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user, team.subdomain)
      visit(contacts_url)
      assert_equal(contacts_url, page.current_url)
      href = '/contacts?direction=desc&field=name'
      link = find(:xpath, "//a[@href='#{href}']")
      link.click
      params = {:field => 'name', :direction => 'desc'}
      assert_equal(contacts_url(params), page.current_url)
      assert_selector(:xpath, <<-ICON.gsub(/^s*|\n/, ''))
        //ul[@class='links']/li
         /a[@href='#{contacts_path(params)}']
         /i[contains(@class, 'fa fa-lg fa-angle-down active')]
      ICON
      logout_user(locker_room.logout_url, :delete)
    end
  end

  def test_sort_with_name_asc
    user = locker_room_users(:weenie)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user, team.subdomain)
      visit(contacts_url)
      assert_equal(contacts_url, page.current_url)
      href = '/contacts?direction=asc&field=name'
      link = find(:xpath, "//a[@href='#{href}']")
      link.click
      params = {:field => 'name', :direction => 'asc'}
      assert_equal(contacts_url(params), page.current_url)
      assert_selector(:xpath, <<-ICON.gsub(/^s*|\n/, ''))
        //ul[@class='links']/li
         /a[@href='#{contacts_path(params)}']
         /i[contains(@class, 'fa fa-lg fa-angle-up active')]
      ICON
      logout_user(locker_room.logout_url, :delete)
    end
  end

  def test_sort_with_code_desc
    user = locker_room_users(:weenie)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user, team.subdomain)
      visit(contacts_url)
      assert_equal(contacts_url, page.current_url)
      href = '/contacts?direction=desc&field=code'
      link = find(:xpath, "//a[@href='#{href}']")
      link.click
      params = {:field => 'code', :direction => 'desc'}
      assert_equal(contacts_url(params), page.current_url)
      assert_selector(:xpath, <<-ICON.gsub(/^s*|\n/, ''))
        //ul[@class='links']/li
         /a[@href='#{contacts_path(params)}']
         /i[contains(@class, 'fa fa-lg fa-angle-down active')]
      ICON
      logout_user(locker_room.logout_url, :delete)
    end
  end
end
