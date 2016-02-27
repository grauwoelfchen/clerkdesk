require 'test_helper'

class SnippetsControllerTest < ActionController::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:snippets)

  def setup
    Snippet.public_activity_off
  end

  def teardown
    Snippet.public_activity_on
  end

  def test_get_index
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index)
      refute_empty(assigns[:snippets])
      assert_template(:index)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_filtered_index_with_tag
    user = locker_room_users(:oswald)
    team = user.teams.first
    snippet = snippets(:favorite_song)
    snippet.tag_list.add('Favorites')
    snippet.save
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index, :t => 'Favorites')
      assert_equal([snippet], assigns[:snippets])
      assert_template(:index)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_show
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      snippet = snippets(:favorite_song)
      get(:show, :id => snippet.id)
      assert_equal(snippet, assigns[:snippet])
      assert_template(:show)
      assert_response(:success)
      logout_user
    end
  end

  def test_get_new
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:new)
      assert_kind_of(Snippet, assigns[:snippet])
      assert_template(:new)
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_post_create_with_validation_errors
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      params = {
        :snippet => {
          :title => ''
        }
      }
      assert_no_difference('Snippet.count', 1) do
        post(:create, params)
      end
      assert_instance_of(Snippet, assigns[:snippet])
      refute(assigns[:snippet].persisted?)
      assert_nil(flash[:notice])
      assert_template(:new)
      assert_template(:partial => 'shared/_error')
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_post_create
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      params = {
        :snippet => {
          :title => 'New snippet'
        }
      }
      assert_difference('Snippet.count', 1) do
        post(:create, params)
      end
      assert_instance_of(Snippet, assigns[:snippet])
      assert(assigns[:snippet].persisted?)
      assert_equal(
        'Snippet has been successfully created.',
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(assigns[:snippet])
      logout_user
    end
  end

  def test_get_edit
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      snippet = snippets(:favorite_song)
      get(:edit, :id => snippet.id)
      assert_equal(snippet, assigns[:snippet])
      assert_template(:edit)
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_put_update_with_validation_errors
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      snippet = snippets(:favorite_song)
      params = {
        :id   => snippet.id,
        :snippet => {
          :title => ''
        }
      }
      put(:update, params)
      assert_equal(snippet, assigns[:snippet])
      assert_nil(flash[:notice])
      assert_template(:edit)
      assert_template(:partial => 'shared/_error')
      assert_template(:partial => '_form')
      assert_response(:success)
      logout_user
    end
  end

  def test_put_update
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      snippet = snippets(:favorite_song)
      params = {
        :id   => snippet.id,
        :snippet => {
          :title => 'Violin snippet'
        }
      }
      put(:update, params)
      assert_equal(params[:snippet][:title], assigns[:snippet].title)
      assert_equal(
        'Snippet has been successfully updated.',
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(assigns[:snippet])
      logout_user
    end
  end

  def test_delete_destroy
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      snippet = snippets(:favorite_song)
      assert_difference('Snippet.count', -1) do
        delete(:destroy, :id => snippet.id)
      end
      assert_equal(snippet, assigns[:snippet])
      refute(assigns[:snippet].persisted?)
      assert_equal(
        'Snippet has been successfully destroyed.',
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(snippets_url)
      logout_user
    end
  end
end
