module UsersHelper
	def gravatar_for(user)
	    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	    default_url = "http://cdn3.iconfinder.com/data/icons/faticons/32/user-01-128.png"  
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=48&d=#{CGI.escape(default_url)}"
	    image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
