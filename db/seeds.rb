if Apartment::Tenant.current == "public"

  conn = ActiveRecord::Base.connection
  Apartment.tenant_names.map do |tenant|
    conn.query(%Q{DROP SCHEMA IF EXISTS #{tenant} CASCADE;})
  end

  team_params = {
    name:      "grauwoelfchen",
    subdomain: "grauwoelfchen",
    owners_attributes: [{
      email:                 "grauwoelfchen@gmail.com",
      password:              "secret",
      password_confirmation: "secret"
    }]
  }

  team = LockerRoom::Team.create_with_owner(team_params)
  team.create_schema
end

if Apartment::Tenant.current == "grauwoelfchen"
  finance_params = {
    name:        "2015.05 Accounting",
    description: "Foo",
    started_at:  Time.new(2015,04, 01, 00, 00, 00, "+00:00"),
    finished_at: Time.new(2016,03, 31, 23, 59, 59, "+00:00"),
    state:       :primary
  }
  finance = Finance.new(finance_params)
  finance.save_with_fiscal_objects

  note_params = {
    title: "05.2015 13th Meeting",
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

  note = Note.new(note_params)
  note.save!
end
