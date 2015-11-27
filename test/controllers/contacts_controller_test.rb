require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:contacts)

  def test_get_index
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index)
      refute_empty(assigns[:contacts])
      assert_template(:index)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_filtered_index_with_tag
    user = locker_room_users(:oswald)
    team = user.teams.first
    contact = contacts(:henry_contact)
    contact.tag_list.add('Penguin')
    contact.save
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index, :t => 'Penguin')
      assert_equal([contact], assigns[:contacts])
      assert_template(:index)
      assert_response(:success)
      logout_user
    end
  end
end
