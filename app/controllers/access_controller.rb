class AccessController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def menu
    # showing name of logged in user on admin page
    @username = session[:username]
    # Display text and links
  end

  def login
    # Login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      # Will return a array. We want a user - therefor .first.
      found_user = AdminUser.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You are logged in."
      redirect_to(admin_path)
    else
      flash.now[:notice] = "Invalid username/password combination"
      render 'login'
    end

  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(access_login_path)
  end

end
