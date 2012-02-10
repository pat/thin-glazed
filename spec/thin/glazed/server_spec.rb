module EventMachine; end

module Thin
  module Glazed
    class HttpsGlazing; end
  end
end

require './lib/thin/glazed/server'

describe Thin::Glazed::Server do
  let(:server) { Thin::Glazed::Server.new '1.2.3.4', 5678 }

  before :each do
    server.stub :puts => true
  end

  describe '#start' do
    it "starts the HTTPS server on the given port" do
      EventMachine.should_receive(:start_server).
        with('1.2.3.4', 5678, Thin::Glazed::HttpsGlazing)

      server.start
    end
  end
end
