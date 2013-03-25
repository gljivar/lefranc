require 'spec_helper'

describe GroupJoinResponse do
  before(:each) do
    @user = User.new
    @user.name = "Test User"
    @user.save

    @group = Group.new
    @group.name = "Test Group"
    @group.save

    @gjr = GroupJoinRequest.new

    @gjr_open = GroupJoinRequest.new
    @gjr_open.should_not be_nil
  end

  it "creates request with response for current user in group and checks if that one user of group votes yes, if do than user is accepted into group" do
    @user_in_group = User.new
    @user_in_group.save
    @group_user = GroupUser.new
    @group_user.user_id = @user_in_group.id
    @group_user.group_id = @group.id
    @group_user.save

    @gjr.user = @user
    @gjr.group = @group
    @gjr.save

    @gjr.id.should_not be_nil
    GroupJoinResponse.where(:user_id == @user_in_group.id).count.should eq(1)
    GroupJoinResponse.find(:first, :user_id == @user_in_group.id).group_join_request_id.should eq(@gjr.id)
    GroupJoinResponse.find(:first, :user_id == @user_in_group.id).user_id.should eq(@user.id)

    # Accept
    @gjresponse = GroupJoinResponse.find(:first, :user_id == @user_in_group.id)
    @gjresponse.accept
    @gjresponse.response.should eq(GroupJoinResponse::R_ACCEPT)
    @gjresponse.group_join_request.should_not be_nil
    @gjresponse.group_join_request_id.should eq(@gjr.id)
    @gjresponse.group_join_request.open.should be_false
    #@gjresponse.group_join_request.save
    gjr_id = @gjr.id
    @gjr = nil
    GroupJoinRequest.find(@gjresponse.group_join_request_id).open.should be_false
    @gjr = GroupJoinRequest.find(gjr_id)
    @gjr.open.should be_false
    #GroupJoinRequest.find(@gjresponse.group_join_request_id).open.should be_false
    GroupJoinRequest.find(@gjr.id).open.should be_false
    # User should be in group now
    GroupUser.where(:user_id => @user.id, :group_id => @group.id).count.should eq(1)

  end


  it "creates request with responses for current 2 users in group and if 1 votes yes then user is accepted into group" do
    @user_in_group = User.new
    @user_in_group.save
    @group_user = GroupUser.new
    @group_user.user_id = @user_in_group.id
    @group_user.group_id = @group.id
    @group_user.save

    @user_in_group_2 = User.new
    @user_in_group_2.save
    @group_user_2 = GroupUser.new
    @group_user_2.user_id = @user_in_group_2.id
    @group_user_2.group_id = @group.id
    @group_user_2.save

    @gjr.user = @user
    @gjr.group = @group
    @gjr.save

    @gjr.id.should_not be_nil
    GroupJoinResponse.where(:user_id == @user.id).count.should eq(2)
    GroupJoinRequest.find(@gjr.id).open.should be_true
    # Accept
    @gjresponse = GroupJoinResponse.find(:first, :user_id == @user_in_group.id)
    @gjresponse.accept
    @gjresponse.response.should eq(GroupJoinResponse::R_ACCEPT)
    @gjresponse.group_join_request_id.should eq(@gjr.id)
    # User should be in group now and request closed
    GroupJoinRequest.find(@gjr.id).open.should be_false
    @gjr.status.should eq(GroupJoinRequest::S_ACCEPTED)
    @gjr.open.should be_false
    GroupUser.where(:user_id => @user.id, :group_id => @group.id).count.should eq(1)

  end


  after(:each) do
    GroupUser.where(:user_id => @user.id, :group_id => @group.id).each do |gu| gu.destroy end
    @gjr.destroy
    @gjr_open.destroy
    @user.destroy
    @group.destroy
  end


end
