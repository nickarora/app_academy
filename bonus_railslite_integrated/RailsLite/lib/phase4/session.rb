require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
        @req = req
        cookie = @req.cookies.find {|c| c.name == '_rails_lite_app'}
        if cookie
            @data = JSON.parse(cookie.value)
        else
            @data = {}
        end
    end

    def [](key)
        @data[key.to_s]
    end

    def []=(key, val)
        @data[key.to_s] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)     
        c = WEBrick::Cookie.new('_rails_lite_app', @data.to_json)
        c.path = "/"
        res.cookies << c
    end
  end
end
