require 'request_context'
require 'request_context/middleware'
require 'request_context/rails/current_user_filter'

require 'rails'
require 'active_support'

module RequestContext
  module Rails
    if ::Rails.application
      ::Rails.application.middleware.insert_after ActionDispatch::ParamsParser, RequestContext::Middleware
    end

    ActiveSupport.on_load(:action_controller) do
      include CurrentUserFilter
    end
  end
end
