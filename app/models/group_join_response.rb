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
end
