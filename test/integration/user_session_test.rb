require 'test_helper'

class UserSessionTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "login and browse site" do
    # login via https
    https!
    get "/login"
    assert_response :success

    post '/user_sessions', :user_session => { :email => users(:sujay).email, :password => users(:sujay).encrypted_password }
    assert_equal '/posts', path
    assert_equal 'Hello sujay, you are now logged in', flash[:notice]

    https!(false)
    get "/posts/all"
    assert_response :success
    assert assigns(:products)
  end
end
