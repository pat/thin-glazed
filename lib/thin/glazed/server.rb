class Thin::Glazed::Server
  attr_reader :host, :port

  def initialize(host, port)
    @host, @port = host, port
  end

  def start
    puts ">> Thin::Glazed HTTPS Proxy (v#{Thin::Glazed::VERSION})"
    puts ">> Listening on #{host}:#{port}"
    # EM.run {
      EventMachine.start_server(host, port, Thin::Glazed::HttpsGlazing)
    # }
  end
end
