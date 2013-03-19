class UserLessonsController < ApplicationController
  before_filter :find_user, :only => [:index]                          

  def index
    @lessons = @user.lessons

    respond_to do |format|
      format.html
      format.json { render :json => @lessons}
    end

  end

  protected

  def find_user
    @user = User.find(params[:user_id])
  end   

end
