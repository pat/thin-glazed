require 'rack/handler/thin_glazed'

class Thin::Glazed::Capybara
  attr_reader :app, :port

  def initialize(app, port)
    @app, @port = app, port

    SslRequirement.ssl_port     = ssl_port
    SslRequirement.non_ssl_port = port
  end

  def run_server
    Thin::Logging.silent = true
    Rack::Handler::ThinGlazed.run app, :Port => port, :ProxyPort => ssl_port
  end

  private

  def ssl_port
    @ssl_port ||= next_available_port
  end

  def next_available_port
    server   = TCPServer.new('127.0.0.1', 0)
    server.addr[1]
  ensure
    server.close if server
  end
end

Capybara.configure do |config|
  config.server { |app, port|
    Thin::Glazed::Capybara.new(app, port).run_server
  }
end

Capybara.register_driver :glazed_webkit do |app|
  Capybara::Driver::Webkit.new(app, :ignore_ssl_errors => true)
end
