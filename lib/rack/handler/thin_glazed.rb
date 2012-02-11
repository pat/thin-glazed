require 'thin/glazed'
require 'rack/content_length'
require 'rack/chunked'
require 'rack/handler'
require 'rack/handler/thin'

class Rack::Handler::ThinGlazed < Rack::Handler::Thin
  def self.run(app, options = {})
    EventMachine.run do
      https_proxy = ::Thin::Glazed::Server.new(options[:Host] || '0.0.0.0',
        options[:ProxyPort] || 3443, options[:Port] || 3000)
      https_proxy.start

      super
    end
  end
end

Rack::Handler.register 'thin_glazed', 'Rack::Handler::ThinGlazed'
