require 'request_context/context'

module RequestContext
  class << self
    attr_accessor :context_class
  end
  self.context_class = RequestContext::Context

  def self.current
    Thread.current['RequestContext_context']
  end

  def self.current=(context)
    Thread.current['RequestContext_context'] = context
  end

  def self.method_missing(symbol, *args)
    if self.context_class.instance_methods.include? symbol
      current.send(symbol, *args) if current
    else
      super
    end
  end
end
