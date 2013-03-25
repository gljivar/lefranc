require 'spec_helper'

describe GroupJoinRequest do
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

  it "can be instantiated" do
    @gjr.should be_an_instance_of(GroupJoinRequest)
    @gjr_open.should be_an_instance_of(GroupJoinRequest)
  end 
 
  it "creates a group user association if there is noone in the group" do
    @gjr.user = @user
    @gjr.group = @group
    @gjr.save

    @gjr.group_user_id.should_not be_nil
    @gjr.status.should eq(GroupJoinRequest::S_ACCEPTED)
    @gjr.open.should be_false
    GroupJoinRequest.find(@gjr.id).open.should be_false
  end

  it "creates a request if there is no open request" do
    @gjr.user = @user    
    @gjr.group = @group
    @gjr.save

    @gjr.id.should_not be_nil     
    @gjr.id.should be > 0
  end

  it "doesn't create a request if user is already in group" do
    @group_user = GroupUser.new
    @group_user.user_id = @user.id
    @group_user.group_id = @group.id
    @group_user.save

    @gjr.user = @user
    @gjr.group = @group
    @gjr.save

    @gjr.id.should be_nil
  end

  it "doesn't create a request if user and group are not associated" do
    @gjr.save
    @gjr.id.should be_nil     

    @gjr.user = @user
    @gjr.save
    @gjr.id.should be_nil     

    @gjr.user = nil
    @gjr.group = nil
    @gjr.save
    @gjr.id.should be_nil     

    @gjr.group = @group
    @gjr.user = @user
    @gjr.save
    @gjr.id.should_not be_nil     
  end


  it "doesn't create a request if there is already open request" do
    @gjr_open.should_not be_nil
 
    @gjr_open.group = @group
    @gjr_open.user = @user
    @gjr_open.save

    @gjr_open.id.should_not be_nil

    @gjr.user = @user    
    @gjr.group = @group
    @gjr.save

    @gjr.id.should be_nil
  end

  it "creates a request if there is no open request" do
    @gjr_open.should_not be_nil

    @gjr_open.group = @group
    @gjr_open.user = @user
    @gjr_open.open = false
    @gjr_open.save

    @gjr_open.id.should_not be_nil

    GroupUser.destroy_all(:group_id => @group.id, :user_id => @user.id)
    GroupUser.where(:group_id => @group.id, :user_id => @user.id).count.should eq(0)

    @gjr.user = @user
    @gjr.group = @group
    @gjr.save

    @gjr.id.should_not be_nil
  end

  it "creates request with response for current user in group" do
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
  end

  it "creates request with responses for current 2 users in group" do
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
  end

  it "destroys responses when request is destroyed" do
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
    @gjr.group_join_responses.all.count.should eq(2)
    GroupJoinResponse.find(:all, :group_join_request_id == @gjr.id).count.should eq(2)
    group_id = @gjr.id

    @gjr.destroy
    GroupJoinRequest.exists?(group_id).should be_false
    @gjr.group_join_responses.all.count.should eq(0)
    GroupJoinResponse.find(:all, :group_join_request_id == group_id).count.should eq(0)
  end


  after(:each) do
    GroupUser.where(:user_id => @user.id, :group_id => @group.id).each do |gu| gu.destroy end
    @gjr.destroy
    @gjr_open.destroy 
    @user.destroy
    @group.destroy
  end  

end
