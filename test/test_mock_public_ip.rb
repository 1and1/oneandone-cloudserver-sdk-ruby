require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestPublicIP < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @public_ip = OneAndOne::PublicIP.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-public-ips.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/public_ips'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @public_ip.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-public-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/public_ips'},
      {:body => JSON.generate(data), :status => 202})
    
    response = @public_ip.create(reverse_dns: data['reverse_dns'])

    # Assertions
    assert_equal response['reverse_dns'], 'example.com'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-public-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/public_ips/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @public_ip.get(ip_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-public-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/public_ips/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @public_ip.modify(ip_id: data['id'], reverse_dns: 'example.es')

    # Assertions
    assert_equal response['reverse_dns'], 'example.es'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-public-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/public_ips/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @public_ip.delete(ip_id: data['id'])

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


end