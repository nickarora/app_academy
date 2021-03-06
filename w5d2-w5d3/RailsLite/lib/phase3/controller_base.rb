require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
    	filename = "views/#{self.class.name.underscore}/#{template_name}.html.erb"
    	template = File.read(filename)
    	content = ERB.new(template).result(binding) #add instance variables
    	render_content(content, "text/html")
    end
  end
end
