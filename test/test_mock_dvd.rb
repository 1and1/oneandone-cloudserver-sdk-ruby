require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestDvd < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @dvd = OneAndOne::Dvd.new(test: true)

  end

  
  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-dvds.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/dvd_isos'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @dvd.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-dvd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/dvd_isos/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @dvd.get(dvd_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


end