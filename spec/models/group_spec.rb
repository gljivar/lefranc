require 'spec_helper'

describe Group do
  before(:each) do
    @user = User.new
    @user.name = "Test User"
    @user.save

    @group = Group.new

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
  end

  it "can be instantiated" do
    @group.should be_an_instance_of Group
  end

  it "can't be saved if user, native and foreign language are not chosen" do
    @group.user = @user
    @group.native_language.should be_nil
    @group.valid?.should be_false
    #@group.save!
    #@group.id.should be_nil

    @group.native_language = @native_language
    #@group.save
    #@group.id.should be_nil

    @group.foreign_language = @foreign_language
    @group.save
    @group.id.should_not be_nil
  end

  after(:each) do
    Group.destroy_all
    @group.destroy
    @user.destroy 
  end
end
