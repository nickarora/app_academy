require 'json'
require 'webrick'

module Phase7
  class Flash
  	
		def initialize(req)
			@req = req

			cookie = @req.cookies.find {|c| (c.name == '_flash_rails_lite_app') }
			
			if cookie
				@current_data = JSON.parse(cookie.value)
			else
				@current_data = {}
			end

			@future_data = {}
		end

		def [](key)
			@current_data[key.to_s]
		end

		def []=(key, val)
			@future_data[key] = val
		end

		def store_flash(res)
			c = WEBrick::Cookie.new('_flash_rails_lite_app', @future_data.to_json) 
			c.path = "/"
    	res.cookies << c
    end

  end
end