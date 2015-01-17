require 'uri'

module Phase5
  class Params
    
    def initialize(req, route_params = {})
      @params = Hash.new(nil)

      @params.merge!(route_params)
      
      if req.query_string
          @params.merge!(parse_www_encoded_form(req.query_string))
      end

      if req.body
          @params.merge!(parse_www_encoded_form(req.body))
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      array = URI::decode_www_form(www_encoded_form)
      params = {}

      array.each do |key,val|
        subkeys = parse_key(key)
        if subkeys.count > 1
          hash = params
          until subkeys.empty?
            newkey = subkeys.shift
            unless subkeys.empty?
              hash[newkey] ||= {}
              hash = hash[newkey]
            else
              hash[newkey] = val
            end
          end
        else
          params[key] = val      
        end
      end
      
      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

  end
end
