require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestUsage < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @usage = OneAndOne::Usage.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-usages.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/usages'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @usage.list

    # Assertions
    assert_equal response['SERVERS'][0]['id'], data['SERVERS'][0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


end