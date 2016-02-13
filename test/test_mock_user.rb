require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestUser < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @user = OneAndOne::User.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-users.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/users'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @user.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-user.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/users'},
      {:body => JSON.generate(data), :status => 202})

    response = @user.create(name: 'Test', email: 'test@example.com',
      password: 'testpass')

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-user.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/users/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @user.get(user_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-user.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/users/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @user.modify(user_id: data['id'], description: 'New Desc')

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-user.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/users/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @user.delete(user_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_api

    # Read in mock JSON
    file = File.read('mock-api/get-user-api.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/users/USER-ID/api"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @user.api(user_id: 'USER-ID')

    # Assertions
    assert_equal response['key'], data['key']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_enable_api

    # Read in mock JSON
    file = File.read('mock-api/modify-user-api.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/users/#{data['id']}/api"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @user.enable_api(user_id: data['id'], active: true)

    # Assertions
    assert_equal response['api']['active'], true

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_api_key

    # Read in mock JSON
    file = File.read('mock-api/get-user-api-key.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/users/USER-ID/api/key"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @user.api_key(user_id: 'USER-ID')

    # Assertions
    assert_equal response['key'], data['key']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_change_key

    # Read in mock JSON
    file = File.read('mock-api/change-api-key.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/users/#{data['id']}/api/key"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @user.change_key(user_id: data['id'])

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ips

    # Read in mock JSON
    file = File.read('mock-api/list-user-ips.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/users/USER-ID/api/ips"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @user.ips(user_id: 'USER-ID')

    # Assertions
    assert_equal response[0], '214.4.143.138'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_ips

    # Read in mock JSON
    file = File.read('mock-api/add-new-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/users/#{data['id']}/api/ips"},
      {:body => JSON.generate(data), :status => 202})
    
    ip1 = '1.2.3.4'

    ips = [ip1]

    response = @user.add_ips(user_id: data['id'], ips: ips)

    # Assertions
    assert_equal response['api']['allowed_ips'][0], '214.4.143.138'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_ip

    # Read in mock JSON
    file = File.read('mock-api/delete-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/users/#{data['id']}/api/ips/IP"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @user.remove_ip(user_id: data['id'], ip: 'IP')

    # Assertions
    assert_equal response['api']['allowed_ips'], []

    # Clear out stubs
    Excon.stubs.clear

  end


end