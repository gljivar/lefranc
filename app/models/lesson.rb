class Lesson < ActiveRecord::Base
  attr_accessible :name, :summary

  validate :user_is_in_group

  validates :name, :presence => true, :allow_nil => false  
  validates :group_id, :presence => true, :allow_nil => false  
  validates :user_id, :presence => true, :allow_nil => false  

  has_many :language_objects

  belongs_to :group

  belongs_to :user

  def native_language_objects
    language_objects.where(:language_id => group.native_language_id)
  end

  def foreign_language_objects
    language_objects.where(:language_id => group.foreign_language_id)
  end

  has_many :words, :through => :language_objects, :source => :translatable, :source_type => "Word"

  def native_words
    words.where("language_objects.language_id" => group.native_language_id)
  end

  def foreign_words
    words.where("language_objects.language_id" => group.foreign_language_id)
  end

  private

  def user_is_in_group
    #if valid? and group.users.include? user
    #  true
    #end
    if !GroupUser.exists?(:user_id => user_id, :group_id => group_id)
      errors.add(:user_id, "User is not member of group for which lesson wants to be made.")
    end
  end
end
