RequestContext
===============

This gem helps keeping track of request scoped (or other units of work) information in a centralized place.

## Usage

By default, a request context can be used to keep track of the current user email and the current request id.
The RequestContext module stores the current context in the `RequestContext.current` thread-safe attribute.

```ruby
require 'request_context'

RequestContext.current = RequestContext::Context.new

# calls to RequestContext are delegated to the current context
RequestContext.request_id = SecureRandom.uuid

```

### Rails

If you're building a rails app, you can easily setup your app by requiring the `request_context/rails` file.
This will do two things:

1. Register a middleware (`RequestContext::Middleware`) for creating and discarding contexts for each request
   and storing the current request id (X-Request-Id header) in it. The middleware will be inserted after the
   ActionDispatch::ParamsParser rails middleware.
2. Add a helper method to ApplicationController::Base that can be used as an before filter
   to store the `current_user` in the request context.

```ruby
# config/initializers/context.rb
require 'request_context/rails'


# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  ...
  before_filter :authenticate_user!
  # must run after user authentication
  before_filter :context_store_current_user
  ...
end

```

One thing worth noticing is that the `RequestContext::Middleware` class has no direct dependency on Rails and can
be used in any `Rack` applications.

You can also write your own middleware to store more request related information,
just make sure it's executed after `RequestContext::Middleware`

```ruby
# config/application.rb
module MyApp
  class Application < Rails::Application
    ...
    config.middleware.insert_after 'RequestContext::Middleware', MyAwesomeMiddleware
    ...
  end
end
```

### Custom Context class

If you need to store more information in the request context, you can extend the `RequestContext::Context`
class and configure `RequestContext` to use it by setting the `context_class` attribute.

```ruby
# config/initializers/context.rb
require 'request_context/rails'

class MyAppContext < RequestContext::Context
  attr_accessor :client_id, :merchant_id, ...
end

RequestContext.context_class = MyAppContext

```
