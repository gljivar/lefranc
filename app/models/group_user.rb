class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  # attr_accessible :title, :body

  validates :user, :uniqueness => { :scope => [:user, :group], :message => "User already belongs to this group" }, :on => :save

end
