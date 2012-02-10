require 'thin/glazed'

module Rack::Handler
  def self.default(options = {})
    Rack::Handler::ThinGlazed
  end
end
