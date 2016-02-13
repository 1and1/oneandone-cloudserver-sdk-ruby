require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestPrivateNetwork < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @private_network = OneAndOne::PrivateNetwork.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-private-networks.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/private_networks'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @private_network.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/private_networks'},
      {:body => JSON.generate(data), :status => 202})
    
    response = @private_network.create(name: data['name'])

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-private-network.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/private_networks/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @private_network.get(private_network_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/private_networks/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @private_network.modify(private_network_id: data['id'], name: 'New Name')

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/private_networks/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @private_network.delete(private_network_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_servers

    # Read in mock JSON
    file = File.read('mock-api/list-pn-servers.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/private_networks/PN-ID/servers"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @private_network.servers(private_network_id: 'PN-ID')

    # Assertions
    assert_equal response.length, 2

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_server

    # Read in mock JSON
    file = File.read('mock-api/get-pn-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/private_networks/PN-ID/servers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @private_network.server(private_network_id: 'PN-ID', server_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_server

    # Read in mock JSON
    file = File.read('mock-api/remove-server-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/private_networks/#{data['id']}/servers/SERVER-ID"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @private_network.remove_server(private_network_id: data['id'], server_id: 'SERVER-ID')

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_servers

    # Read in mock JSON
    file = File.read('mock-api/attach-server-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/private_networks/PN-ID/servers"},
      {:body => JSON.generate(data), :status => 202})
    
    server1 = '<SERVER-ID>'

    servers = [server1]

    response = @private_network.add_servers(private_network_id: 'PN-ID', servers: servers)

    # Assertions
    assert_equal response[0]['name'], data[0]['name']

    # Clear out stubs
    Excon.stubs.clear

  end


end