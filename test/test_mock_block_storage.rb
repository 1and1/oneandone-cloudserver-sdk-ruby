require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestBlockStorage < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @block_storage = OneAndOne::BlockStorage.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-block-storages.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/block_storages'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @block_storage.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-block-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/block_storages'},
      {:body => JSON.generate(data), :status => 202})
    
    response = @block_storage.create(name: data['name'],
                                     description: data['description'],
                                     size: data['size'],
                                     datacenter_id: data['datacenter']['id']
                                     )

    # Assertions
    assert_equal response['name'], data['name']
    assert_equal response['description'], data['description']
    assert_equal response['size'], data['size']
    assert_equal response['datacenter']['id'], data['datacenter']['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-block-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/block_storages/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @block_storage.get(block_storage_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-block-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/block_storages/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @block_storage.modify(block_storage_id: data['id'], name: 'New Name')

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-block-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/block_storages/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @block_storage.delete(block_storage_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_attach_block_storage

    # Read in mock JSON
    file = File.read('mock-api/attach-block-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/block_storages/#{data['id']}/server"},
               {:body => JSON.generate(data), :status => 202})

    response = @block_storage.attach_server(block_storage_id: "#{data['id']}")

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_detach_block_storage

    # Read in mock JSON
    file = File.read('mock-api/detach-block-storage.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/block_storages/#{data['id']}/server"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @block_storage.detach_server(block_storage_id: data['id'])

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


end