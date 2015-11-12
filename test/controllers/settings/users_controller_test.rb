require 'test_helper'

module Settings
  class UsersControllerTest < ActionController::TestCase
    locker_room_fixtures(:teams, :users, :mateships)

    def test_get_edit
      user = locker_room_users(:oswald)
      team = user.teams.first
      within_subdomain(team.subdomain) do
        login_user(user)
        get(:edit)
        assert_equal(user, assigns[:user])
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
        params = {
          :user => {
            :name   => 'Oswald',
            :locale => ''
          }
        }
        put(:update, params)
        assert_equal(user, assigns[:user])
        assert_nil(flash[:notice])
        assert_equal(
          'Account could not be updated.',
          ActionController::Base.helpers.strip_tags(flash[:alert])
        )
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
        params = {
          :user => {
            :name   => 'Mr. Oswald',
            :locale => 'ja'
          }
        }
        @controller.send(:set_locale)
        assert_equal(:en, session[:locale])
        put(:update, params)
        assert_equal(params[:user][:locale], assigns[:user].locale)
        # will be cleared for reset locale in set_locale before_action
        assert_nil(session[:locale])
        assert_equal(
          'Account has been successfully updated.',
          ActionController::Base.helpers.strip_tags(flash[:notice])
        )
        assert_response(:redirect)
        assert_redirected_to(user_settings_url)
        logout_user
      end
    end
  end
end
