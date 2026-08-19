# frozen_string_literal: true

require 'bundler/setup'
require 'minitest/autorun'
require 'mocha/minitest'
require 'simplecov'
SimpleCov.start

require 'omniauth/strategies/elitmus'

OmniAuth.config.test_mode = true

module BlockTestHelper
  def test(name, &)
    method_name = "test_#{name.gsub(/\s+/, '_')}"
    raise "Method already defined: #{method_name}" if method_defined?(method_name.to_sym)

    define_method(method_name, &)
  end
end

module CustomAssertions
  def assert_has_key(key, hash, msg = nil)
    msg = message(msg) { "Expected #{hash.inspect} to have key #{key.inspect}" }
    assert hash.key?(key), msg
  end

  def refute_has_key(key, hash, msg = nil)
    msg = message(msg) { "Expected #{hash.inspect} not to have key #{key.inspect}" }
    refute hash.key?(key), msg
  end
end

class TestCase < Minitest::Test
  extend BlockTestHelper
  include CustomAssertions
end

class StrategyTestCase < TestCase
  def setup
    @request = stub('Request')
    @request.stubs(:params).returns({})
    @request.stubs(:cookies).returns({})
    @request.stubs(:env).returns({})
    @request.stubs(:scheme).returns('http')
    @request.stubs(:ssl?).returns(false)

    @client_id = '123'
    @client_secret = '53cr3tz'
  end

  def strategy
    @strategy ||= begin
      args = [@client_id, @client_secret, @options].compact
      OmniAuth::Strategies::Elitmus.new(nil, *args).tap do |strategy|
        strategy.stubs(:request).returns(@request)
      end
    end
  end
end

Dir[File.expand_path('support/**/*', __dir__)].each(&method(:require))
