require "test_helper"

class PersonSortTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:people)

  def test_sort_with_name_desc
    user = locker_room_users(:weenie)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      visit(people_url)
      assert_equal(people_url, page.current_url)
      href = "/people?direction=desc&field=name"
      link = find(:xpath, "//a[@href='#{href}']")
      link.click
      params = {:field => "name", :direction => "desc"}
      assert_equal(people_url(params), page.current_url)
      assert_selector(:xpath, <<-ICON.gsub(/^s*|\n/, ""))
        //ul[@class='sort-links']/li
         /a[@href='#{people_path(params)}']
         /i[contains(@class, 'fa fa-lg fa-angle-down active')]
      ICON
      logout_user(locker_room.logout_url, :delete)
    end
  end

  def test_sort_with_name_asc
    user = locker_room_users(:weenie)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      visit(people_url)
      assert_equal(people_url, page.current_url)
      href = "/people?direction=asc&field=name"
      link = find(:xpath, "//a[@href='#{href}']")
      link.click
      params = {:field => "name", :direction => "asc"}
      assert_equal(people_url(params), page.current_url)
      assert_selector(:xpath, <<-ICON.gsub(/^s*|\n/, ""))
        //ul[@class='sort-links']/li
         /a[@href='#{people_path(params)}']
         /i[contains(@class, 'fa fa-lg fa-angle-up active')]
      ICON
      logout_user(locker_room.logout_url, :delete)
    end
  end

  def test_sort_with_slug_desc
    user = locker_room_users(:weenie)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      visit(people_url)
      assert_equal(people_url, page.current_url)
      href = "/people?direction=desc&field=slug"
      link = find(:xpath, "//a[@href='#{href}']")
      link.click
      params = {:field => "slug", :direction => "desc"}
      assert_equal(people_url(params), page.current_url)
      assert_selector(:xpath, <<-ICON.gsub(/^s*|\n/, ""))
        //ul[@class='sort-links']/li
         /a[@href='#{people_path(params)}']
         /i[contains(@class, 'fa fa-lg fa-angle-down active')]
      ICON
      logout_user(locker_room.logout_url, :delete)
    end
  end
end
