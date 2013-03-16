class Lesson < ActiveRecord::Base
  attr_accessible :name, :summary

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

end
