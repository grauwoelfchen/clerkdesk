require "test_helper"

class AccountScopTest < Capybara::Rails::TestCase
  locker_room_fixtures(:accounts, :members, :users)

  def setup
    @account_piano   = locker_room_accounts(:playing_piano)
    @account_penguin = locker_room_accounts(:penguin_patrol)
    Note.scoped_to(@account_piano).create(:title => "Musical instrument")
    Note.scoped_to(@account_penguin).create(:title => "The ice")
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
    user = @account_piano.owners.first
    note = Note.scoped_to(user.account).first
    login_user(user)
    visit(note_url(note, :subdomain => @account_piano.subdomain))
    assert_content("Musical instrument")
  end

  def test_scope_for_a_note_on_other_account_penguin
    note = Note.scoped_to(@account_penguin).first
    user = @account_piano.owners.first
    login_user(user)
    assert_raise(ActiveRecord::RecordNotFound) do
      visit(note_url(note, :subdomain => @account_piano.subdomain))
    end
  end

  def test_scope_for_a_note_on_exact_account_penguin
    user = @account_penguin.owners.first
    note = Note.scoped_to(user.account).first
    login_user(user)
    visit(note_url(note, :subdomain => @account_penguin.subdomain))
    assert_content("The ice")
  end

  def test_scope_for_a_note_on_other_account_piano
    note = Note.scoped_to(@account_piano).first
    user = @account_penguin.owners.first
    login_user(user)
    assert_raise(ActiveRecord::RecordNotFound) do
      visit(note_url(note, :subdomain => @account_penguin.subdomain))
    end
  end
end
