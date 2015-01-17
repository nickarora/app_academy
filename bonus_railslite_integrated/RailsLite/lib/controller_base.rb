require_relative './url_helper'

class ControllerBase
	include UrlHelper

  attr_reader :req, :res

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false

    @params = Params.new(req, route_params)

    # protect_from_forgery with: :exception
  	session[:form_authenticity_token] ||= SecureRandom.urlsafe_base64

  	if [:post, :patch, :put].include?(format_req(@req.request_method)) && 
    	 @params[:authenticity_token] != session[:form_authenticity_token]
  		raise "Unauthorized Action"
		end
  end

  # Helper method to alias @already_built_response
  def already_built_response?
  	@already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Can not re-render content." if self.already_built_response?
    @already_built_response = true
    res.status = 302
    res.header['location'] = url
    session.store_session(@res)
    flash.store_flash(@res)
	end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, type)
    raise "Can not re-render content." if self.already_built_response?
    @already_built_response = true
    res.body = content
    res.content_type = type

    session.store_session(@res)
    flash.store_flash(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
  	filename = "views/#{self.class.name.underscore}/#{template_name}.html.erb"
  	template = File.read(filename)
  	content = ERB.new(template).result(binding) #add instance variables
  	render_content(content, "text/html")
  end

  # method exposing a `Session` object
  def session
  	@session ||= Session.new(self.req)
  end

  # method exposing a `Flash` object
	def flash
		@flash ||= Flash.new(self.req)
	end

  def form_authenticity_token
  	session[:form_authenticity_token]
  end

  def format_req(r)
  	r.to_s.downcase.to_sym
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  	self.send(name)
  	render(name) unless already_built_response?  #default response!
  end

end
