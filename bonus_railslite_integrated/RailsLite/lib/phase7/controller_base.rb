require_relative '../phase6/controller_base'
require_relative './flash'

module Phase7
	class ControllerBase < Phase6::ControllerBase
    	def redirect_to(url)
            flash.store_flash(@res)
            super(url)
        end

        def render_content(content, type)
        	flash.store_flash(@res)
            super(content, type)
        end

        # method exposing a `Flash` object
        def flash
        	@flash ||= Flash.new(self.req)
        end
	end
end