class Group < ActiveRecord::Base
  attr_accessible :name, :native_language_id, :foreign_language_id

  belongs_to :native_language, :class_name => "Language"
  belongs_to :foreign_language, :class_name => "Language"

  has_many :lessons

  belongs_to :user

  has_many :group_users
  has_many :users, :through => :group_users

  has_many :group_join_requests

  validates :user, :native_language, :foreign_language, :presence => true, :allow_nil => false, :on => :save
end
