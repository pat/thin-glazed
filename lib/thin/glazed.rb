require 'eventmachine'
require 'thin'

module Thin::Glazed
  #
end

require 'thin/glazed/http_client'
require 'thin/glazed/http_glazing'
require 'thin/glazed/https_glazing'
require 'thin/glazed/server'
require 'thin/glazed/version'

if defined?(Rack)
  require 'rack/handler/thin_glazed'
end

if defined?(Capybara) && Capybara.respond_to?(:configure)
  require 'thin/glazed/capybara'
end
