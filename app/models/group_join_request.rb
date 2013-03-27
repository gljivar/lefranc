class GroupJoinRequest < ActiveRecord::Base
  S_REQUESTED = 100
  S_ACCEPTED = 202 
  S_REJECTED = 403 
  S_CANCELED = 410

  belongs_to :group_user
  belongs_to :user
  belongs_to :group

  has_many :group_join_responses, :dependent => :destroy

  attr_accessible :open, :status
  attr_accessible :user_id, :group_id, :group_user

  validates :user_id, :presence => true
  validates :group_id, :presence => true
  validate :there_can_be_only_one_open_group_join_request
  validate :user_cannot_make_request_if_already_in_group

  after_initialize :init
  after_create :create_group_join_responses
  
  def init
    self.status ||= GroupJoinRequest::S_REQUESTED
  end

  def accept
    self.open = false
    self.status = GroupJoinRequest::S_ACCEPTED
    self.save
  end

  
  # If there is noone in the group then just join, else create group join responses  
  def create_group_join_responses 
   if self.group.users.count <= 0 and self.group.user == nil
     group_user = GroupUser.new
     group_user.user = self.user
     group_user.group = self.group
     group_user.save

     self.open = false 
     self.status = GroupJoinRequest::S_ACCEPTED
     self.group_user = group_user
     self.save
   else
     self.group.users.reject{|user| user == self.user}.each do |user|  
       gjres = GroupJoinResponse.new 
       gjres.group_join_request_id = self.id
       gjres.user = self.user
       gjres.save
     end
   end
  end

  #validation methods
  def there_can_be_only_one_open_group_join_request 
    if GroupJoinRequest.where(:user_id => user_id, :group_id => group_id, :open => true).where('id != ?', id).count > 0
      errors.add(:user_id, "Already requested to join group")
    end
  end

  def user_cannot_make_request_if_already_in_group
    if GroupUser.where(:user_id => user_id, :group_id => group_id).where('id != ?', group_user_id).count > 0
      errors.add(:user_id, "Already member of requested group")
    end
  end 
end
