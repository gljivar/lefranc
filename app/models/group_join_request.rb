class GroupJoinRequest < ActiveRecord::Base
  S_REQUESTED = 100
  S_ACCEPTED = 202 
  S_REJECTED = 403 
  S_CANCELED = 410

  belongs_to :group_user
  belongs_to :user
  belongs_to :group
  attr_accessible :open, :status

  validates :user_id, :presence => true
  validates :group_id, :presence => true
  validates_uniqueness_of :user_id, :scope => [:group_id, :open, :status]
end
