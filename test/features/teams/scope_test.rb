require "test_helper"

class TeamScopTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :memberships)

  def setup
    @team_piano   = locker_room_teams(:playing_piano)
    @team_penguin = team_with_schema(:penguin_patrol)

    Apartment::Tenant.switch!(@team_piano.subdomain)
    Note.delete_all
    Note.create(:id => 12345, :title => "Musical instrument")
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    Note.delete_all
    Note.create(:id => 54321, :title => "The ice")
    Apartment::Tenant.reset
  end

  def teardown
    logout_user
  end

  def test_scoped_visibility_on_team_piano
    user = @team_piano.owners.first
    login_user(user)
    visit(notes_url(:subdomain => @team_piano.subdomain))
    assert_content("Musical instrument")
    refute_content("The ice")
  end

  def test_scoped_visibility_on_team_penguin
    user = @team_penguin.owners.first
    login_user(user)
    visit(notes_url(:subdomain => @team_penguin.subdomain))
    refute_content("Musical instrument")
    assert_content("The ice")
  end

  def test_scope_for_a_note_on_exact_team_piano
    Apartment::Tenant.switch!(@team_piano.subdomain)
    note = Note.last
    user = @team_piano.owners.first
    login_user(user)
    visit(note_url(note, :subdomain => @team_piano.subdomain))
    assert_content("Musical instrument")
  end

  def test_scope_for_a_note_on_other_team_penguin
    Apartment::Tenant.switch!(@team_piano.subdomain)
    note = Note.last
    user = @team_penguin.owners.first
    login_user(user)
    assert_raise(ActiveRecord::RecordNotFound) do
      visit(note_url(note, :subdomain => @team_penguin.subdomain))
    end
    refute_content("Musical instrument")
  end

  def test_scope_for_a_note_on_exact_team_penguin
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    note = Note.last
    user = @team_penguin.owners.first
    login_user(user)
    visit(note_url(note, :subdomain => @team_penguin.subdomain))
    assert_content("The ice")
  end

  def test_scope_for_a_note_on_other_team_piano
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    note = Note.last
    user = @team_piano.owners.first
    login_user(user)
    assert_raise(ActiveRecord::RecordNotFound) do
      visit(note_url(note, :subdomain => @team_piano.subdomain))
    end
    refute_content("The ice")
  end
end
