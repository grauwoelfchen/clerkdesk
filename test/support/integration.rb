module Integration
  def before_setup
    @default_host = locker_room.scope.default_url_options[:host]
    locker_room.scope.default_url_options[:host] = Capybara.app_host
    super
  end

  def after_teardown
    super
    locker_room.scope.default_url_options[:host] = @default_host
  end

  def signin_user(user, password='secret')
    visit(locker_room.login_url)
    fill_in('Email',    :with => user.email)
    fill_in('Password', :with => password)
    click_button('Signin')
    user
  end

  def signout_user
    visit(locker_room.logout_url)
    nil
  end

  # The DSL block to prepare signined user within subdomain.
  #
  #     1. load user by user_name, directly
  #     2. enter subdomain
  #     3. call signin_user
  #     4. eval block by context (js or not) with (optional) args user and team
  #     5. call signout_user
  def behaves_as(user_name, js: false, &inner_block)
    test_case = lambda {
      user = locker_room_users(user_name)
      team = user.teams.first!
      within_subdomain(team.subdomain) do
        signin_user(user)
        inner_block.call(user, team)
        signout_user
      end
    }
    if js
      within_js_driver(&test_case)
    else
      test_case.call
    end
  end

  def within_js_driver
    tld_length          = Rails.application.config.action_dispatch.tld_length
    default_url_options = Rails.application.routes.default_url_options

    # set subdomain host for phantomjs using xip.io
    Rails.application.config.action_dispatch.tld_length = JS_HOST.scan(/\./).length
    Rails.application.routes.default_url_options[:host] = JS_HOST

    current_driver      = Capybara.current_driver
    default_app_host    = Capybara.app_host
    default_server_port = Capybara.server_port

    Capybara.current_driver = :poltergeist
    Capybara.app_host       = "http://#{test_host}/"
    Capybara.server_port    = test_port

    page.driver.browser.url_blacklist = [
      'fontawesome-webfont.woff',
      'fontawesome-webfont.ttf',
      'fontawesome-webfont.svg',
      'icons.woff',
      'icons.ttf',
      'icons.svg'
    ]

    yield

    Capybara.server_port    = default_server_port
    Capybara.app_host       = default_app_host
    Capybara.current_driver = current_driver

    Rails.application.routes.default_url_options        = default_url_options
    Rails.application.config.action_dispatch.tld_length = tld_length
  end

  private

  def test_host
    locker_room.scope.default_url_options[:host]
  end

  def test_port
    test_host =~ /:([0-9]+)/
    $1 || 3000
  end
end
