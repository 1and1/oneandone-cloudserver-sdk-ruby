require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestLoadBalancer < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @load_balancer = OneAndOne::LoadBalancer.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-load-balancers.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/load_balancers'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @load_balancer.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/load_balancers'},
      {:body => JSON.generate(data), :status => 202})
    
    rule1 = {
      'protocol' => 'TCP',
      'port_balancer' => 80,
      'port_server' => 80,
      'source' => '0.0.0.0'
    }

    rules = [rule1]

    response = @load_balancer.create(name: 'Test LB', description: 'Example Desc',
      health_check_test: 'TCP', health_check_interval: 40, persistence: true,
      persistence_time: 1200, method: 'ROUND_ROBIN', rules: rules)

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-load-balancer.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/load_balancers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @load_balancer.get(load_balancer_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/load_balancers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @load_balancer.modify(load_balancer_id: data['id'],
      name: 'New Name')

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/load_balancers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @load_balancer.delete(load_balancer_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ips

    # Read in mock JSON
    file = File.read('mock-api/list-lb-servers.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/load_balancers/LOAD-BALANCER-ID/server_ips"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @load_balancer.ips(load_balancer_id: 'LOAD-BALANCER-ID')

    # Assertions
    assert_equal response.length, 2

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ip

    # Read in mock JSON
    file = File.read('mock-api/get-lb-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/load_balancers/LOAD-BALANCER-ID/server_ips/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @load_balancer.ip(load_balancer_id: 'LOAD-BALANCER-ID', ip_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_ip

    # Read in mock JSON
    file = File.read('mock-api/detach-server-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/load_balancers/#{data['id']}/server_ips/IP-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @load_balancer.remove_ip(load_balancer_id: data['id'], ip_id: 'IP-ID')

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_ips

    # Read in mock JSON
    file = File.read('mock-api/assign-server-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/load_balancers/#{data['id']}/server_ips"},
      {:body => JSON.generate(data), :status => 202})

    ip1 = '<IP-ID>'

    ips = [ip1]
    
    response = @load_balancer.add_ips(load_balancer_id: data['id'], ips: ips)

    # Assertions
    assert_equal response['server_ips'].length, 1

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_rules

    # Read in mock JSON
    file = File.read('mock-api/list-lb-rules.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/load_balancers/LOAD-BALANCER-ID/rules"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @load_balancer.rules(load_balancer_id: 'LOAD-BALANCER-ID')

    # Assertions
    assert_equal response.length, 2

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_rule

    # Read in mock JSON
    file = File.read('mock-api/get-lb-rule.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/load_balancers/LOAD-BALANCER-ID/rules/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @load_balancer.rule(load_balancer_id: 'LOAD-BALANCER-ID', rule_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_rules

    # Read in mock JSON
    file = File.read('mock-api/add-rule-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/load_balancers/#{data['id']}/rules"},
      {:body => JSON.generate(data), :status => 202})

    rule2 = {
      'protocol' => 'TCP',
      'port_balancer' => 90,
      'port_server' => 90,
      'source' => '0.0.0.0'
    }

    rules = [rule2]
    
    response = @load_balancer.add_rules(load_balancer_id: data['id'],
      rules: rules)

    # Assertions
    assert_equal response['rules'].length, 3

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_rule

    # Read in mock JSON
    file = File.read('mock-api/remove-rule-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/load_balancers/#{data['id']}/rules/RULE-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @load_balancer.remove_rule(load_balancer_id: data['id'], rule_id: 'RULE-ID')

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


end