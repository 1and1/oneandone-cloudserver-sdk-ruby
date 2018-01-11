require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestSshKey < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @ssh_key = OneAndOne::SshKey.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-ssh-keys.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/ssh_keys'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @ssh_key.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-ssh-key.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/ssh_keys'},
      {:body => JSON.generate(data), :status => 202})
    
    response = @ssh_key.create(name: data['name'])

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-ssh-key.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/ssh_keys/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @ssh_key.get(ssh_key_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-ssh-key.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/ssh_keys/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @ssh_key.modify(ssh_key_id: data['id'], name: 'New Name')

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-ssh-key.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/ssh_keys/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @ssh_key.delete(ssh_key_id: data['id'])

    # Assertions
    assert_equal response['state'], 'DELETING'

    # Clear out stubs
    Excon.stubs.clear

  end


end