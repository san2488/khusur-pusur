require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures :users
  fixtures :posts
  fixtures :categories
  setup do
    @user = users(:sujay)
    @user_session = UserSession.create({ :email => users(:sujay).email, :password => '123456' })
    session[:id] = @user_session.id
    #post user_sessions_path, :user_session => { :email => users(:sujay).email, :password => '123456' }
    @post = Post.new({:title=>"Hello World", :content=>"This is a post", :category_id => categories(:ruby).id})
    @post.user = @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: {:title=>@post.title, :content=>@post.content, :category_id=>@post.category.id}
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    put :update, id: @post, post: { :title=>"Edited Title"  }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
