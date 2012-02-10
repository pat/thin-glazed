module EventMachine
  class Connection; end
  class DefaultDeferrable; end
end

require './lib/thin/glazed/http_client'

describe Thin::Glazed::HttpClient do
  let(:client)     { Thin::Glazed::HttpClient.new proxy }
  let(:deferrable) { double('deferrable') }
  let(:proxy)      { double('proxy') }

  before :each do
    EventMachine::DefaultDeferrable.stub :new => deferrable
  end

  describe '#connection_completed' do
    it "calls succeed on the deferrable object" do
      deferrable.should_receive(:succeed)

      client.connection_completed
    end
  end

  describe '#receive_data' do
    it "passes on the data to the proxy" do
      proxy.should_receive(:relay_from_client).with('foo bar baz')

      client.receive_data('foo bar baz')
    end
  end

  describe '#send' do
    it "buffers the data to send" do
      deferrable.should_receive(:callback)

      client.send('foo bar baz')
    end

    it "eventually sends the data provided" do
      deferrable.stub(:callback) do |block|
        block.call
      end

      client.should_receive(:send_data).with('foo bar baz')

      client.send('foo bar baz')
    end
  end

  describe '#unbind' do
    it "unbinds itself from the proxy" do
      proxy.should_receive(:unbind_client)

      client.unbind
    end
  end
end
