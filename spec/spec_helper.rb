require 'rack/test'
require 'rspec'
require_relative '../lib/telegram_echo_server.rb'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure { |c| c.include RSpecMixin }
