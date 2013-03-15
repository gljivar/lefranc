class Group < ActiveRecord::Base
  attr_accessible :name

  belongs_to :native_language, :class_name => "Language"
  belongs_to :foreign_language, :class_name => "Language"

  has_many :lessons

end
