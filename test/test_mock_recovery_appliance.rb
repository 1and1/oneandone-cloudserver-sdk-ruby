require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestServerAppliance < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @appliance = OneAndOne::RecoveryAppliance.new(test: true)

  end

  
  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-recovery-appliances.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/recovery_appliances'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @appliance.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-recovery-appliance.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/recovery_appliances/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @appliance.get(appliance_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


end