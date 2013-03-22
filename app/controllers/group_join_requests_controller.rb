class GroupJoinRequestsController < ApplicationController
  before_filter :find_group, :except => [:destroy]
  before_filter :find_user, :except => [:destroy]
  before_filter :find_group_join_request, :only => [:destroy, :update]

  def create
    @gjr = GroupJoinRequest.new
    @gjr.group_id = @group.id
    @gjr.status = GroupJoinRequest::S_REQUESTED
    @gjr.closed = false
    @gjr.user_id = @user.id

    @gjresponses = []
    @group.users.each do |user|
      @gjresponse = GroupJoinResponse.new
      @gjresponse.user = user
      @gjresponses.push @gjresponse
    end

    respond_to do |format|
      if !is_current_user(@user)
        format.html { redirect_to(groups_path, 
          :notice => "You can only join groups by yourself.") }
        format.json { render :json => [], :status => :unauthorized } 
      end 
      if save_all @gjr, @gjresponses
        format.html { redirect_to(groups_path,
          :notice => "Your request is made. You have to wait for approval from other group members.") }
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
      @gjr.status = GroupJoinRequest::S_CANCELED
      @gjr.closed = true
      @gjr.save
    end
 
    #TODO: Unauthorized also checking and return according to that 
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

  def save_all(gjr, gjresponses)
    ActiveRecord::Base.transaction do
      gjr.save
      gjresponses.each do |gjresponse|
        gjresponse.group_join_request = gjr 
        gjresponse.response = GroupJoinResponse::R_INITIAL 
        gjresponse.save 
      end
    end 
  end
end
