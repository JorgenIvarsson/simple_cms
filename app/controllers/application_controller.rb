class ApplicationController < ActionController::Base


  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(access_login_path)
      # redirect prevents the requested action from running
    end
  end

end
