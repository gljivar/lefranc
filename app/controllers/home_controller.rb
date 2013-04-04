class HomeController < ApplicationController
  skip_before_filter :require_login, :only => [:index]

  def index
    #TODO: Take two most recent groups that a user belongs to, that has some language object or lesson activity
    #TODO: Exclude duplicates
    #Now: Take two groups you most recently entered

    #TODO: This is hotfix
    if current_user
      @group_users = GroupUser.where(:user_id => current_user.id).order('created_at desc').limit(5)
      @groups = []
      @group_users.each do |group_user| @groups.push(Group.find(group_user.group_id)) end
    
      #TODO: Take lessons with some recent activity
      @lessons =[]
      @groups.each do |group| @lessons = @lessons + Lesson.where(:group_id => group.id) end
    end 
  end
end
