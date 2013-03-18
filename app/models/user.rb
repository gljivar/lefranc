class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid, :email, :nickname, :first_name, :last_name, :description, :image, :phone
	
  def self.create_with_omniauth(auth)
	create! do |user|
		user.provider = auth["provider"]
		user.uid = auth["uid"]
	
		user.name = auth["info"]["name"]
		user.email = auth["info"]["email"]
		user.nickname = auth["info"]["nickname"]
		user.first_name = auth["info"]["first_name"]
		user.last_name = auth["info"]["last_name"]
		user.description = auth["info"]["description"]
		user.image = auth["info"]["image"]
		user.phone = auth["info"]["phone"]
		user.token = auth["info"]["token"]
		user.secret = auth["info"]["secret"]
	end
  end

  has_many :group_users
  has_many :groups, :through => :group_users 

end
