require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestSharedStorage < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @shared_storage = OneAndOne::SharedStorage.new(test: true)

  end

  
  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-storages.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/shared_storages'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @shared_storage.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/shared_storages'},
      {:body => JSON.generate(data), :status => 202})
    
    response = @shared_storage.create(name: data['name'],
      description: data['description'], size: 200)

    # Assertions
    assert_equal response['size'], 200

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/shared_storages/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @shared_storage.get(shared_storage_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/shared_storages/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @shared_storage.modify(shared_storage_id: data['id'],
      name: data['name'], size: 250)

    # Assertions
    assert_equal response['name'], 'My shared storage test rename'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/shared_storages/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @shared_storage.delete(shared_storage_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_servers

    # Read in mock JSON
    file = File.read('mock-api/attach-server-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/shared_storages/#{data['id']}/servers"},
      {:body => JSON.generate(data), :status => 202})
    
    server1 = {
      'id' => '<SERVER-ID>',
      'rights' => 'RW'
    }

    servers = [server1]

    response = @shared_storage.add_servers(shared_storage_id: data['id'],
      servers: servers)

    # Assertions
    assert_equal response['servers'][0]['id'], '638ED28205B1AFD7ADEF569C725DD85F'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_servers

    # Read in mock JSON
    file = File.read('mock-api/storage-servers.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/shared_storages/SHARED-STORAGE-ID/servers"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @shared_storage.servers(shared_storage_id: 'SHARED-STORAGE-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_server

    # Read in mock JSON
    file = File.read('mock-api/get-server-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/shared_storages/SHARED-STORAGE-ID/servers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @shared_storage.server(shared_storage_id: 'SHARED-STORAGE-ID',
      server_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_server

    # Read in mock JSON
    file = File.read('mock-api/detach-server-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/shared_storages/#{data['id']}/servers/#{data['servers'][0]['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @shared_storage.remove_server(shared_storage_id: data['id'],
      server_id: data['servers'][0]['id'])

    # Assertions
    assert_equal response['servers'].length, 1

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_access

    # Read in mock JSON
    file = File.read('mock-api/list-credentials.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/shared_storages/access"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @shared_storage.access

    # Assertions
    assert_equal response['user_domain'], data['user_domain']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_change_password

    # Read in mock JSON
    file = File.read('mock-api/change-password.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/shared_storages/access"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @shared_storage.change_password(password: 'asdasdfgagsw32')

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


end