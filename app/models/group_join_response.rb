class GroupJoinResponse < ActiveRecord::Base
  R_INITIAL = 100
  R_ACCEPT = 202
  R_REJECT = 403
  R_HIDE = 303

  belongs_to :group_join_request
  belongs_to :user
  attr_accessible :response

  after_initialize :init

  def init
    self.response ||= GroupJoinResponse::R_INITIAL
  end

  def accept
    self.response = GroupJoinResponse::R_ACCEPT
    self.save
    if user_can_enter_group
      close_group_join_request
      add_user_to_group
    end
  end

  private

  def user_can_enter_group
    all_responses_count = GroupJoinResponse.where(:group_join_request_id => group_join_request_id).count
    all_accepted_responses_count = GroupJoinResponse.where(:group_join_request_id => group_join_request_id, :response => R_ACCEPT).count
    if (all_accepted_responses_count.to_f / all_responses_count.to_f) >= 0.5 
      true
    else
      false
    end
  end

  def close_group_join_request
    group_join_request.accept
  end

  def add_user_to_group 
    group_user = GroupUser.new
    group_user.user_id = group_join_request.user.id
    group_user.group_id = group_join_request.group_id
    group_user.save 
  end
end
