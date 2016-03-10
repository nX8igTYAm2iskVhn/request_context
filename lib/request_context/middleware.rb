require 'request_context'
require 'securerandom'

module RequestContext
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      context = RequestContext.context_class.new
      if context.respond_to? :request_id
        context.request_id = env['HTTP_X_REQUEST_ID']
        context.request_id ||= env['action_dispatch.request_id']
        context.request_id ||= SecureRandom.uuid.gsub('-', '')
      end
      RequestContext.current = context

      @app.call(env)
    ensure
      RequestContext.current = nil
    end
  end
end
