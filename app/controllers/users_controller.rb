class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy] 

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, :notice => "User has been updated" }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @language.errors, :status => :unprocessable_entity }
       end
    end
  end

  def edit
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, :notice => "User has been deleted" }
      format.json { head :no_content }
    end 
  end

  def index
    @users = User.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @users}
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end 
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end

end
