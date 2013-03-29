require 'spec_helper'

describe Lesson do
  # user should be in already existing group
  before(:each) do
    @user = User.new
    @user.name = "Test User"
    @user.save

    @native_language = Language.new
    @native_language.user = @user
    @native_language.name = "Test Language native"
    @native_language.english_name = "Test Language native"
    @native_language.save

    @foreign_language = Language.new
    @foreign_language.user = @user
    @foreign_language.name = "Test Language foreign"
    @foreign_language.english_name = "Test Language foreign"
    @foreign_language.save

    @group = Group.new
    @group.name = "Test Group"
    @group.foreign_language = @foreign_language
    @group.native_language = @native_language
    @group.save

    @group_user = GroupUser.new
    @group_user.user = @user
    @group_user.group = @group
    @group_user.save
    
    @group_user.id.should_not be_nil 
  end
  
  it 'creates a lesson if group is defined, user is in group and name is defined. User belongs to group.' do
    @lesson = Lesson.new
    @lesson.save
    @lesson.id.should be_nil

    @lesson.name = "Test lesson"
    @lesson.save
    @lesson.id.should be_nil

    @lesson.group = @group
    @lesson.save
    @lesson.id.should be_nil
 
    @lesson.user = @user 
    @lesson.save
    @lesson.id.should_not be_nil
  end

  it 'does not create a lesson if group is defined, user is not in group and name is defined.' do
    @lesson = Lesson.new
    @lesson.save
    @lesson.id.should be_nil

    @lesson.name = "Test lesson"
    @lesson.save
    @lesson.id.should be_nil

    @lesson.group = @group
    @lesson.save
    @lesson.id.should be_nil

    @user_not_in_group = User.new
    @user_not_in_group.name = "Test not group user"
    @user_not_in_group.save
    
    @lesson.user = @user_not_in_group 
    @lesson.save
    @lesson.id.should be_nil
  end

  after(:each) do
    @group_user.destroy
    @group.destroy
    @user.destroy
    @native_language.destroy
    @foreign_language.destroy
  end
end
