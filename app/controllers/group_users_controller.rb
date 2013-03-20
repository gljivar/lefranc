class GroupUsersController < ApplicationController
  before_filter :find_group, :only => [:index, :create, :destroy]
  before_filter :find_user, :only => [:create, :destroy]

  def index
    @users = @group.users

    respond_to do |format|
      format.html
      format.json { render :json => @users}
    end

  end

  def create
    @group_user = GroupUser.new
    @group_user.user_id = @user.id
    @group_user.group_id = @group.id

    respond_to do |format|
      if @group_user.save
        format.html { redirect_to(groups_path,
          :notice => "Group user was successfully created.") }
        format.json { render :json =>@group_user,
          :status => :created, :location => @group_user }
      else
        format.html { redirect_to(groups_path,
          :notice => "Group user was not successfully created.") } 
        format.json { render :json => @group_user.errors,
          :status => :unprocessable_entity }
        end
      end
 
  end

  def destroy
    @group_user = GroupUser.find_by_user_id_and_group_id(@user.id, @group.id) 

    @group_user.destroy

    respond_to do |format|
      format.html { redirect_to groups_path,
        :notice => "Group user has been deleted" }
      format.json { head :no_content }
    end

  end
  
  protected

  def find_user
    @user = User.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end
end