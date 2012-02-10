module EventMachine
  class Connection; end
end

require './lib/thin/glazed/http_glazing'

class Thin::Glazed::HttpClient; end

describe Thin::Glazed::HttpGlazing do
  let(:glazing) { Thin::Glazed::HttpGlazing.new }
  let(:client)  { double('client', :send_data => true) }

  before :each do
    EventMachine.stub :connect => client
  end

  describe '#receive_data' do
    it "initializes a local client to port 3000 using itself as the proxy" do
      EventMachine.should_receive(:connect).
        with('127.0.0.1', 3000, Thin::Glazed::HttpClient, glazing).
        and_return(client)

      glazing.receive_data('qux')
    end

    it "sends the data on to the client" do
      client.should_receive(:send_data).with('quux')

      glazing.receive_data('quux')
    end
  end

  describe '#relay_from_client' do
    it "sends the data through from the client" do
      glazing.should_receive(:send_data).with('baz')

      glazing.relay_from_client 'baz'
    end
  end

  describe '#unbind' do
    it "closes the client's connection" do
      client.should_receive(:close_connection)

      glazing.unbind
    end
  end

  describe '#unbind_client' do
    it "closes the connection once it's ready" do
      glazing.should_receive(:close_connection_after_writing)

      glazing.unbind_client
    end
  end
end
