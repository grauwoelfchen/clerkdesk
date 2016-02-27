require 'test_helper'

class TeamScopTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def setup
    @team_piano   = locker_room_teams(:playing_piano)
    @team_penguin = team_with_schema(:penguin_patrol)

    Apartment::Tenant.switch!(@team_piano.subdomain)
    Snippet.public_activity_off
    Snippet.delete_all
    Snippet.create(:id => 12345, :title => 'Musical instrument')
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    Snippet.delete_all
    Snippet.create(:id => 54321, :title => 'The ice')
    Apartment::Tenant.reset
    Snippet.public_activity_on
  end

  def test_scoped_visibility_on_team_piano
    user = @team_piano.primary_owner
    within_subdomain(@team_piano.subdomain) do
      signin_user(user)
      visit(snippets_url(:subdomain => @team_piano.subdomain))
      assert_content('Musical instrument')
      refute_content('The ice')
      signout_user
    end
  end

  def test_scoped_visibility_on_team_penguin
    user = @team_penguin.primary_owner
    within_subdomain(@team_penguin.subdomain) do
      signin_user(user)
      visit(snippets_url(:subdomain => @team_penguin.subdomain))
      refute_content('Musical instrument')
      assert_content('The ice')
      signout_user
    end
  end

  def test_scope_for_a_snippet_on_exact_team_piano
    Apartment::Tenant.switch!(@team_piano.subdomain)
    snippet = Snippet.last
    user = @team_piano.primary_owner
    within_subdomain(@team_piano.subdomain) do
      signin_user(user)
      visit(snippet_url(snippet, :subdomain => @team_piano.subdomain))
      assert_content('Musical instrument')
      signout_user
    end
  end

  def test_scope_for_a_snippet_on_other_team_penguin
    Apartment::Tenant.switch!(@team_piano.subdomain)
    snippet = Snippet.last
    user = @team_penguin.primary_owner
    within_subdomain(@team_penguin.subdomain) do
      signin_user(user)
      assert_raise(ActiveRecord::RecordNotFound) do
        visit(snippet_url(snippet, :subdomain => @team_penguin.subdomain))
      end
      refute_content('Musical instrument')
      signout_user
    end
  end

  def test_scope_for_a_snippet_on_exact_team_penguin
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    snippet = Snippet.last
    user = @team_penguin.primary_owner
    within_subdomain(@team_penguin.subdomain) do
      signin_user(user)
      visit(snippet_url(snippet, :subdomain => @team_penguin.subdomain))
      assert_content('The ice')
      signout_user
    end
  end

  def test_scope_for_a_snippet_on_other_team_piano
    Apartment::Tenant.switch!(@team_penguin.subdomain)
    snippet = Snippet.last
    user = @team_piano.primary_owner
    within_subdomain(@team_piano.subdomain) do
      signin_user(user)
      assert_raise(ActiveRecord::RecordNotFound) do
        visit(snippet_url(snippet, :subdomain => @team_piano.subdomain))
      end
      refute_content('The ice')
      signout_user
    end
  end
end
