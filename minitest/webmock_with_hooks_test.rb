require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'webmock/minitest'
require 'minitest/hooks/test'

class WebMockWithHooksTest < Minitest::Test
 include Minitest::Hooks

  def before_all
    stub_request(:get, "http://example.com/").to_return(body: "Hello, world!")
  end
  def after_all
    WebMock.reset!
  end

  def test_stub_exists_and_allow_request
    response = Net::HTTP.get(URI("http://example.com/"))
    assert_equal "Hello, world!", response
  end

   def test_stub_does_not_exist
    assert_raises(WebMock::NetConnectNotAllowedError) do
      Net::HTTP.get(URI("http://example123.com/"))
    end
  end

end

