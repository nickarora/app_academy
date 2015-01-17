require_relative '../phase8/controller_base'
require_relative '../phase6/router'

module RailsLite
	include Phase6 #router
	class ControllerBase < Phase8::ControllerBase
	end
end