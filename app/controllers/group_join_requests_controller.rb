class GroupJoinRequestsController < ApplicationController
  before_filter :find_group, :except => [:destroy]
  before_filter :find_user, :except => [:destroy]
  before_filter :find_group_join_request, :only => [:destroy, :update]

  def create
    @gjr = GroupJoinRequest.new
    @gjr.group_id = @group.id
    @gjr.user_id = current_user.id
    @gjr.save

    #TODO: Chack if there other possibilities
    respond_to do |format|
      if @gjr.id > 0
        format.html { redirect_to(groups_path,
          :notice => "Your request has been made. You have to wait for approval from other group members.") }
        format.json { render :json =>@gjr,
          :status => :created, :location => @gjr }
      else
        format.html { redirect_to(groups_path, 
          :notice => "You have already requested to join this group. If this is an error send email to admin.") }
        format.json { render :json => @gjr.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      #TODO: Differentiate unauthorized
      if @gjr.user == current_user and @gjr.update_attributes(params[:group_join_request])
        format.html { redirect_to groups_path, :notice => 'Group join request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to groups_path, :notice => 'Group join request was not successfully updated.' }
        format.json { render json: @gjr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user == @gjr.user
      @gjr.destroy
    end
 
    respond_to do |format|
      format.html { redirect_to groups_path,
        :notice => "Request has been canceled" }
      format.json { head :no_content }
    end
  end

  protected

  def find_group_join_request
    @gjr = GroupJoinRequest.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

end
