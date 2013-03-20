class UserGroupsController < ApplicationController
  before_filter :find_user, :only => [:index] 

  helper_method :current_user_is_parameter

  def index
    @groups = @user.groups

    respond_to do |format|
      format.html
      format.json { render :json => @groups}
    end

  end

  protected

  def find_user
    @user = User.find(params[:user_id])
  end

  def current_user_is_parameter
    current_user == @user
  end
end
