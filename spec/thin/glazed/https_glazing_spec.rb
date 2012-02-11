module EventMachine
  class Connection; end
end

require './lib/thin/glazed/http_glazing'
require './lib/thin/glazed/https_glazing'

class Thin::Glazed::HttpClient; end

describe Thin::Glazed::HttpsGlazing do
  let(:glazing) { Thin::Glazed::HttpsGlazing.new 3444 }
  let(:client)  { double('client', :send_data => true) }

  before :each do
    EventMachine.stub :connect => client
  end

  describe '#post_init' do
    it "sets up the SSL connection" do
      base = File.expand_path File.join(
        File.dirname(__FILE__), '..', '..', '..', 'lib', 'data'
      )
      glazing.should_receive(:start_tls).with(
        :private_key_file => File.join(base, 'glazed.key'),
        :cert_chain_file  => File.join(base, 'glazed.pem'),
        :verify_peer      => false
      )

      glazing.post_init
    end
  end

  describe '#receive_data' do
    it "adds a HTTPS header to the HTTP request" do
      http = <<-HTTP
GET /assets/icons/facebook.png HTTP/1.1
Host: localhost:3443
Accept: */*\r\n\r
      HTTP

      https = <<-HTTPS
GET /assets/icons/facebook.png HTTP/1.1
Host: localhost:3443
Accept: */*\r
X_FORWARDED_PROTO: https\r\n\r
      HTTPS

      client.should_receive(:send_data).with(https)

      glazing.receive_data(http)
    end
  end
end
