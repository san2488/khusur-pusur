require 'test_helper'

class UserSessionTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :categories

  test "login and create post" do

    #Go to login page
    get login_path
    assert_response :success

    #Login and authenticate user
    post user_sessions_path, :user_session => { :email => users(:sujay).email, :password => '123456' }
    assert_redirected_to posts_path
    assert_equal 'Hello Sujay, you are now logged in.', flash[:notice]

    #Create new post
    user = User.find_by_email(users(:sujay).email)
    category = Category.find_by_name(categories(:ruby).name)
    post posts_path, :post => {:title => 'Hello World Test', :content => 'Lorem Ipsum. This is some Content', :category_id => category.id }
    assert_response :redirect
    assert_equal 'Post was successfully created', flash[:notice]

    #Logout
    get logout_path
    assert_redirected_to root_url
    assert_equal 'You are now logged out.', flash[:notice]
  end
end


