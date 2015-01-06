require 'addressable/uri'
require 'rest-client'

# bin/my_script.rb
url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1/contacts',
).to_s

# puts RestClient.post(url, {:user => {:name => 'Putin', email: "putin@russia.gov"}})
# puts RestClient.get(url)


begin
  puts RestClient.get(url)
rescue => e
  puts e.response
end
