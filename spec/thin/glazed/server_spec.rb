module EventMachine; end

module Thin
  module Glazed
    class HttpsGlazing; end
  end
  module Logging; end
end

require './lib/thin/glazed/server'

describe Thin::Glazed::Server do
  let(:server) { Thin::Glazed::Server.new '1.2.3.4', 5678, 1234 }

  before :each do
    server.stub :log => true
  end

  describe '#start' do
    it "starts the HTTPS server with the given ports" do
      EventMachine.should_receive(:start_server).
        with('1.2.3.4', 5678, Thin::Glazed::HttpsGlazing, 1234)

      server.start
    end
  end
end
