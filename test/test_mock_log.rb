require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestLog < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @log = OneAndOne::Log.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-logs.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/logs'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @log.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-log.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/logs/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @log.get(log_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


end