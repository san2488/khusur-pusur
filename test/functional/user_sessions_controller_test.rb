require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup do
    @user_session = user_sessions(:admin_login)
  end

  test "should create user_session" do
    assert_difference('UserSession.count') do
      post :create, user_session: { :email=>@user_session.user.email, :password=>'123456' }
    end

    assert_redirected_to posts_path()
  end

  test "should destroy user_session" do
    #Simulate login
    session[:id] = @user_session.id
    assert_difference('UserSession.count', -1) do
      delete :destroy, id: user_sessions(:admin_login)
    end

    assert_redirected_to root_url
  end
end
