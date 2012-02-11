class Thin::Glazed::Server
  include Thin::Logging

  attr_reader :host, :port, :client_port

  def initialize(host, port, client_port)
    @host, @port, @client_port = host, port, client_port
  end

  def start
    log ">> Thin::Glazed HTTPS Proxy (v#{Thin::Glazed::VERSION})"
    log ">> Listening on #{host}:#{port}"

    EventMachine.start_server host, port, Thin::Glazed::HttpsGlazing,
      client_port
  end
end
