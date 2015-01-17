module UrlHelper

	def link_to(name, url = '#')
		"<a href=#{url}>#{name}</a>"
	end

	def button_to(name, url = '#', method)
		"<form action=#{url} method='#{method.to_s.upcase}'><input type='submit' value='#{name}'></form>"
	end

end