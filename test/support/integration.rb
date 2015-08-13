module Integration
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
    ENV['TEST_HOST'].to_s
  end

  def test_port
    test_host =~ /:([0-9]+)/
    $1 || '3001'
  end
end
