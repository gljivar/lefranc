class GroupJoinRequestsController < ApplicationController
  before_filter :find_group 
  before_filter :find_user

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
  end

  protected

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
