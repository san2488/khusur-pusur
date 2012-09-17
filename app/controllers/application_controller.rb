class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time

  before_filter :maintain_user_session_and_user
  before_filter :current_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3ef815416f775098fe977004015c6193'

  def is_admin?
    @current_user && @current_user.is_admin
  end

  def require_admin
    unless is_admin?
      flash[:notice] = "Please login as admin to perform this task"
      redirect_to(logout_path)
    end
  end

  def require_user
    unless @user
      flash[:notice] = "Please login to continue"
      redirect_to(new_user_session_path)
    end
  end

  def require_no_user
    if @user
      flash[:notice] = "You must logout before you can login or register"
      redirect_to(logout_path)
    end
  end

  def current_user
    if @user
    @current_user = User.find(@user)
      end
  end
  private

  def maintain_user_session_and_user
    if session[:id]
      if @application_session = UserSession.find_by_id(session[:id])
        @application_session.update_attributes(
            :ip_address => request.remote_addr,
            :path => request.path_info
        )
        @user = @application_session.user
      else
        session[:id] = nil
        redirect_to(root_url)
      end
    end
  end
end
