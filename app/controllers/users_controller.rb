class UsersController < ApplicationController
  #before_filter :ensure_login, :only => [:edit, :update, :destroy]
  before_filter :ensure_logout, :only => [:new, :create]
  def index
    @users = Post.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user_session = @user.sessions.create
      session[:id] = @user_session.id
      flash[:notice] = "Welcome #{@user.name}, you are now registered"
      redirect_to(root_url)
    else
      render(:action => 'new')
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile successfully updated!"
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
  end

end
