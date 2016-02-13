require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestImage < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @image = OneAndOne::Image.new(test: true)

  end

  
  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-images.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/images'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @image.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create
    
    # Read in mock JSON
    file = File.read('mock-api/create-image.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/images'},
      {:body => JSON.generate(data), :status => 202})
    
    response = @image.create(server_id: data['server_id'], name: data['name'],
      frequency: data['frequency'], num_images: data['num_images'])

    # Assertions
    assert_equal response['name'], data['name']
    assert_equal response['frequency'], data['frequency']
    assert_equal response['num_images'], data['num_images']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify
    
    # Read in mock JSON
    file = File.read('mock-api/edit-image.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/images/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @image.modify(image_id: data['id'], name: data['name'])

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get
    
    # Read in mock JSON
    file = File.read('mock-api/get-image.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/images/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @image.get(image_id: data['id'])

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-image.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/images/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @image.delete(image_id: data['id'])

    # Assertions
    assert_equal response['name'], data['name']
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end

end


