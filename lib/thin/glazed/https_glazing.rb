class Thin::Glazed::HttpsGlazing < Thin::Glazed::HttpGlazing
  def post_init
    start_tls(
      :private_key_file => File.join(cert_path, 'glazed.key'),
      :cert_chain_file  => File.join(cert_path, 'glazed.pem'),
      :verify_peer      => false
    )
  end

  def receive_data(data)
    super data.gsub(/\r\n\r\n/, "\r\nX_FORWARDED_PROTO: https\r\n\r\n")
  end

  private

  def cert_path
    @cert_path ||= File.expand_path File.join(
      File.dirname(__FILE__), '..', '..', 'data'
    )
  end
end
