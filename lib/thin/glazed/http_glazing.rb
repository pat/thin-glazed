class Thin::Glazed::HttpGlazing < EventMachine::Connection
  def receive_data(data)
    client.send_data data unless data.nil?
  end

  def relay_from_server(data)
    send_data data unless data.nil?
  end

  def unbind
    client.close_connection
    @client = nil
  end

  def unbind_server
    close_connection_after_writing
    @client = nil
  end

  private

  def client
    @client ||= EventMachine.connect '127.0.0.1', 3000,
      Thin::Glazed::HttpClient, self
  end
end
