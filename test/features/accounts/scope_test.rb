require "test_helper"

class AccountScopTest < Capybara::Rails::TestCase
  locker_room_fixtures(:accounts, :members, :users)

  def setup
    @account_piano   = locker_room_accounts(:playing_piano)
    @account_penguin = account_with_schema(:penguin_patrol)

    Apartment::Tenant.switch!(@account_piano.subdomain)
    Note.delete_all
    Note.create(:id => 12345, :title => "Musical instrument")
    Apartment::Tenant.switch!(@account_penguin.subdomain)
    Note.delete_all
    Note.create(:id => 54321, :title => "The ice")
    Apartment::Tenant.reset
  end

  def teardown
    logout_user
  end

  def test_scoped_visibility_on_account_piano
    user = @account_piano.owners.first
    login_user(user)
    visit(notes_url(:subdomain => @account_piano.subdomain))
    assert_content("Musical instrument")
    refute_content("The ice")
  end

  def test_scoped_visibility_on_account_penguin
    user = @account_penguin.owners.first
    login_user(user)
    visit(notes_url(:subdomain => @account_penguin.subdomain))
    refute_content("Musical instrument")
    assert_content("The ice")
  end

  def test_scope_for_a_note_on_exact_account_piano
    Apartment::Tenant.switch!(@account_piano.subdomain)
    note = Note.last
    user = @account_piano.owners.first
    login_user(user)
    visit(note_url(note, :subdomain => @account_piano.subdomain))
    assert_content("Musical instrument")
  end

  def test_scope_for_a_note_on_other_account_penguin
    Apartment::Tenant.switch!(@account_piano.subdomain)
    note = Note.last
    user = @account_penguin.owners.first
    login_user(user)
    assert_raise(ActiveRecord::RecordNotFound) do
      visit(note_url(note, :subdomain => @account_penguin.subdomain))
    end
    refute_content("Musical instrument")
  end

  def test_scope_for_a_note_on_exact_account_penguin
    Apartment::Tenant.switch!(@account_penguin.subdomain)
    note = Note.last
    user = @account_penguin.owners.first
    login_user(user)
    visit(note_url(note, :subdomain => @account_penguin.subdomain))
    assert_content("The ice")
  end

  def test_scope_for_a_note_on_other_account_piano
    Apartment::Tenant.switch!(@account_penguin.subdomain)
    note = Note.last
    user = @account_piano.owners.first
    login_user(user)
    assert_raise(ActiveRecord::RecordNotFound) do
      visit(note_url(note, :subdomain => @account_piano.subdomain))
    end
    refute_content("The ice")
  end
end
