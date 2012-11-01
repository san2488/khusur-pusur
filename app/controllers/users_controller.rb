class UsersController < ApplicationController
  before_filter :is_self_or_admin?, :only => [:edit, :update, :destroy, :index]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :is_not_primary_admin?, :only => [:edit, :destroy]

  def is_not_primary_admin?
    @user = User.find_by_id(params[:id])
    #@user.email != 'sujay.narsale@gmail.com'
  end

  def is_self_or_admin?
    @is_self = @current_user && ((@current_user.id == @user.id) || @current_user.is_admin)
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @user_session = @user.user_sessions.create
      session[:id] = @user_session.id
      flash[:notice] = "Welcome #{@user.name.capitalize}, you are now registered"
      redirect_to(posts_path)
    else
      render(:action => 'new')
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id]) # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile successfully updated!"
      redirect_to user_path
    else
      render :action => :edit
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy

    redirect_to users_path
  end

end
