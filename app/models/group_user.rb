class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  # attr_accessible :title, :body

  validates :uniqueness => { :scope => [:user, :group], :message => "User already belongs to this group" }
end
