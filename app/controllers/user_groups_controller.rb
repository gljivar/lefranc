class UserGroupsController < ApplicationController
  before_filter :find_user, :only => [:index] 

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


end
