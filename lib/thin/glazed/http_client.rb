class Thin::Glazed::HttpClient < EventMachine::Connection
  attr_reader :proxy

  def initialize(proxy)
    @proxy     = proxy
    @connected = EM::DefaultDeferrable.new
  end

  def connection_completed
    @connected.succeed
  end

  def receive_data(data)
    @proxy.relay_from_server(data)
  end

  def send(data)
    @connected.callback { send_data data }
  end

  def unbind
    proxy.unbind_server
  end
end
