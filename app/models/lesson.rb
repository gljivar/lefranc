class Lesson < ActiveRecord::Base
  attr_accessible :name, :summary

  has_many :language_objects

end
