require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestMonitoringCenter < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @monitoring_center = OneAndOne::MonitoringCenter.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-monitoring-center-usages.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/monitoring_center'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_center.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-monitoring-center.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_center/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_center.get(server_id: data['id'], period: 'LAST_24H')

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


end