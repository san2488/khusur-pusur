class UserSessionsController < ApplicationController

  before_filter :ensure_login, :only => :destroy
  before_filter :ensure_logout, :only => [:new, :create]

  def index
    redirect_to(new_user_session_path)
  end

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      session[:id] = @user_session.id
      flash[:notice] = "Hello #{@user_session.user.name}, you are now logged in"
      redirect_to(root_url)
    else
      render(:action => 'new')
    end
  end

  def destroy
    UserSession.destroy(@application_session)
    session[:id] = @user = nil
    flash[:notice] = "You are now logged out"
    redirect_to(root_url)
  end
end
