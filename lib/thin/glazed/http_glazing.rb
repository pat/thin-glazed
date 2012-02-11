class Thin::Glazed::HttpGlazing < EventMachine::Connection
  attr_reader :client_port

  def initialize(client_port)
    @client_port = client_port
  end

  def receive_data(data)
    client.send_data data unless data.nil?
  end

  def relay_from_client(data)
    send_data data unless data.nil?
  end

  def unbind
    client.close_connection
    @client = nil
  end

  def unbind_client
    close_connection_after_writing
    @client = nil
  end

  private

  def client
    @client ||= EventMachine.connect '127.0.0.1', client_port,
      Thin::Glazed::HttpClient, self
  end
end
