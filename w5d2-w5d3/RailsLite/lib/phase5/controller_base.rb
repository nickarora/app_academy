require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params

    # setup the controller
    def initialize(req, res, route_params = {})
    	super(req, res)
    	@params = Params.new(req, route_params)

        # protect_from_forgery with: :exception
    	session[:form_authenticity_token] ||= SecureRandom.urlsafe_base64

    	if [:post, :patch, :put].include?(format_req(@req.request_method)) && 
    		 @params[:authenticity_token] != session[:form_authenticity_token]
				raise "Unauthorized Action"
			end

        end

    def form_authenticity_token
    	session[:form_authenticity_token]
    end

    def format_req(r)
        r.to_s.downcase.to_sym
    end

  end
end
