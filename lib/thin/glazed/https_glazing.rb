class Thin::Glazed::HttpsGlazing < Thin::Glazed::HttpGlazing
  def post_init
    start_tls(
      :private_key_file => '/Users/pat/Code/inspire9/builder/local.key',
      :cert_chain_file  => '/Users/pat/Code/inspire9/builder/local.pem',
      :verify_peer      => false
    )
  end

  def receive_data(data)
    super data.gsub(/\r\n\r\n/, "\r\nX_FORWARDED_PROTO: https\r\n\r\n")
  end
end
