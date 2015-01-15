require_relative '../phase7/controller_base'
require_relative './url_helper'

module Phase8
	class ControllerBase < Phase7::ControllerBase
    	include UrlHelper
    end
end