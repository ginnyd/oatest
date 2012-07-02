class User
	
	include Mongoid::Document
	field :provider, type: String
	field :uid, type: String
	field :name, type: String
	field :email, type: String

	attr_protected :provider, :uid, :name, :email


	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth['provider']
			user.uid = auth['uid']
			if auth['info']
				user.name = auth['info']['name'] || ""
				user.email = auth['info']['email'] || ""
				if user.name == "" && auth['info']['nickname']
					user.name = auth['info']['nickname']
				end
			end
		end
	end

end
