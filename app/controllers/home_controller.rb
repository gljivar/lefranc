class HomeController < ApplicationController
  skip_before_filter :require_login, :only => [:index]

  def index
    #TODO: Take two most recent groups that a user belongs to, that has some language object or lesson activity
    #TODO: Exclude duplicates
    #Now: Take two groups you most recently entered

    @group_users = GroupUser.where(:user_id => current_user.id).order('created_at desc').limit(5)
    @groups = []
    @group_users.each do |group_user| @groups.push(Group.find(group_user.group_id)) end
    
    #TODO: Take lessons with some recent activity
  end
end
