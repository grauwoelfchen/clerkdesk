require 'test_helper'

class TeamScopTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def setup
    @team_piano   = locker_room_teams(:playing_piano)
    @team_penguin = team_with_schema(:penguin_patrol)

    Apartment::Tenant.switch!(@team_piano.subdomain)
    Note.public_activity_off
    Note.delete_all
    Note.create(:id => 12345, :title => 'Musical instrument')
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    Note.delete_all
    Note.create(:id => 54321, :title => 'The ice')
    Apartment::Tenant.reset
    Note.public_activity_on
  end

  def test_scoped_visibility_on_team_piano
    user = @team_piano.owners.first
    within_subdomain(user.team.subdomain) do
      signin_user(user)
      visit(notes_url(:subdomain => @team_piano.subdomain))
      assert_content('Musical instrument')
      refute_content('The ice')
      signout_user
    end
  end

  def test_scoped_visibility_on_team_penguin
    user = @team_penguin.owners.first
    within_subdomain(user.team.subdomain) do
      signin_user(user)
      visit(notes_url(:subdomain => @team_penguin.subdomain))
      refute_content('Musical instrument')
      assert_content('The ice')
      signout_user
    end
  end

  def test_scope_for_a_note_on_exact_team_piano
    Apartment::Tenant.switch!(@team_piano.subdomain)
    note = Note.last
    user = @team_piano.owners.first
    within_subdomain(user.team.subdomain) do
      signin_user(user)
      visit(note_url(note, :subdomain => @team_piano.subdomain))
      assert_content('Musical instrument')
      signout_user
    end
  end

  def test_scope_for_a_note_on_other_team_penguin
    Apartment::Tenant.switch!(@team_piano.subdomain)
    note = Note.last
    user = @team_penguin.owners.first
    within_subdomain(user.team.subdomain) do
      signin_user(user)
      assert_raise(ActiveRecord::RecordNotFound) do
        visit(note_url(note, :subdomain => @team_penguin.subdomain))
      end
      refute_content('Musical instrument')
      signout_user
    end
  end

  def test_scope_for_a_note_on_exact_team_penguin
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    note = Note.last
    user = @team_penguin.owners.first
    within_subdomain(user.team.subdomain) do
      signin_user(user)
      visit(note_url(note, :subdomain => @team_penguin.subdomain))
      assert_content('The ice')
      signout_user
    end
  end

  def test_scope_for_a_note_on_other_team_piano
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    note = Note.last
    user = @team_piano.owners.first
    within_subdomain(user.team.subdomain) do
      signin_user(user)
      assert_raise(ActiveRecord::RecordNotFound) do
        visit(note_url(note, :subdomain => @team_piano.subdomain))
      end
      refute_content('The ice')
      signout_user
    end
  end
end
