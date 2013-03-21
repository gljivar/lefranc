class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
	
  helper_method :current_user
  helper_method :is_current_user

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      respond_to do |format|
        format.html { redirect_to :signin,
          :notice => "You must be signed in to access this page" }
        format.json { render :json => {:success => false, :message => 'You must be signed in to access this page.'}, :status => :unauthorized }
      end
    end
  end

  def is_current_user(user)
    @current_user == user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


end
