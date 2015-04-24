require "test_helper"

class AccountScopTest < Capybara::Rails::TestCase
  locker_room_fixtures(:accounts, :members, :users)

  def setup
    @account_piano   = locker_room_accounts(:playing_piano)
    @account_penguin = locker_room_accounts(:penguin_patrol)
    Note.scoped_to(@account_piano).create(:title => "Musical instrument")
    Note.scoped_to(@account_penguin).create(:title => "The ice")
  end

  def test_scoped_visibility_for_account_piano
    login_as(@account_piano.owners.first)
    visit(notes_url(:subdomain => @account_piano.subdomain))
    assert_content("Musical instrument")
    refute_content("The ice")
  end

  def test_scoped_visibility_for_account_penguin
    login_as(@account_penguin.owners.first)
    visit(notes_url(:subdomain => @account_penguin.subdomain))
    refute_content("Musical instrument")
    assert_content("The ice")
  end
end
