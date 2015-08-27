module Integration
  def signin_user(user, password="secret")
    visit(locker_room.login_url)
    fill_in("Email",    :with => user.email)
    fill_in("Password", :with => password)
    click_button("Signin")
    user
  end

  def signout_user
    #visit(locker_room.logout_url)
    current_driver = Capybara.current_driver
    Capybara.current_driver = :rack_test
    page.driver.submit(:delete, locker_room.logout_url, {})
    Capybara.current_driver = current_driver
    nil
  end

  def within_js_driver
    Capybara.current_driver = :poltergeist

    default_url_host    = default_url_options[:host]
    default_app_host    = Capybara.app_host
    default_server_port = Capybara.server_port

    default_url_options[:host] = test_host
    Capybara.app_host          = "http://#{test_host}"
    Capybara.server_port       = test_port

    page.driver.browser.url_blacklist = [
    ]

    visit('/assets/application.js')
    visit('/assets/application.css')

    yield

    default_url_options[:host] = default_url_host
    Capybara.app_host          = default_app_host
    Capybara.server_port       = default_server_port
    Capybara.use_default_driver
  end

  private

  def test_host
    current_host = locker_room.scope.default_url_options[:host]
    if current_host
      if current_host =~ /^http/
        URI.parse(current_host).host
      else
        current_host
      end
    else
      ENV["TEST_HOST"].to_s
    end
  end

  def test_port
    test_host =~ /:([0-9]+)/
    $1 || 3002
  end
end
