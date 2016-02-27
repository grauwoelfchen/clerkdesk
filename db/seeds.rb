if Apartment::Tenant.current == 'public'

  conn = ActiveRecord::Base.connection
  Apartment.tenant_names.map do |tenant|
    conn.query(%Q{DROP SCHEMA IF EXISTS #{tenant} CASCADE;})
  end

  team_params = {
    name:      'Developers',
    subdomain: 'developers',
    owners_attributes: [{
      email:                 'grauwoelfchen@gmail.com',
      name:                  'Yasuhiro Asaka',
      username:              'grauwoelfchen',
      password:              'secret',
      password_confirmation: 'secret'
    }]
  }
  LockerRoom::Team.create_with_owner(team_params)
end

if Apartment::Tenant.current == 'developers'
  ledger_params = {
    name:        '2015.05',
    description: 'Foo',
    started_at:  Time.new(2015,04, 01, 00, 00, 00, '+00:00'),
    finished_at: Time.new(2016,03, 31, 23, 59, 59, '+00:00'),
    state:       :primary
  }
  ledger = Finance::Ledger.new(ledger_params)
  ledger.save_with_fiscal_objects

  snippet_params = {
    title: '05.2015 13th Meeting',
    content: <<-CONTENT
## Summary

* Foo
* Bar

## Schedule

|Foo|Bar|
|---|---|
|foo|bar|
  CONTENT
  }

  Snippet.public_activity_off
  snippet = Snippet.new(snippet_params)
  snippet.save!
  Snippet.public_activity_on
end
