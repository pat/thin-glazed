require 'thin/glazed'
require 'rack/content_length'
require 'rack/chunked'
require 'rack/handler'
require 'rack/handler/thin'

module Rack
  module Handler
    class ThinGlazed < Rack::Handler::Thin
      def self.run(app, options = {})
        EventMachine.run do
          https_proxy = ::Thin::Glazed::Server.new(options[:Host] || '0.0.0.0',
            options[:ProxyPort] || 3443)
          https_proxy.start

          super
        end
      end
    end

    register 'thin_glazed', 'Rack::Handler::ThinGlazed'
  end
end
