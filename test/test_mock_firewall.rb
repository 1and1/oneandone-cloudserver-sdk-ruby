require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestFirewall < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @firewall = OneAndOne::Firewall.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-firewalls.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/firewall_policies'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @firewall.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/firewall_policies'},
      {:body => JSON.generate(data), :status => 202})
    
    rule1 = {
      'protocol' => 'TCP',
      'port_from' => 80,
      'port_to' => 80,
      'source' => '0.0.0.0'
    }

    rules = [rule1]

    response = @firewall.create(name: 'Test', description: 'Test Desc',
      rules: rules)

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-firewall.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/firewall_policies/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @firewall.get(firewall_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/firewall_policies/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @firewall.modify(firewall_id: data['id'], name: 'New Name')

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/remove-firewall-policy.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/firewall_policies/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @firewall.delete(firewall_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ips

    # Read in mock JSON
    file = File.read('mock-api/list-server-ips-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/firewall_policies/FIREWALL-ID/server_ips"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @firewall.ips(firewall_id: 'FIREWALL-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ip

    # Read in mock JSON
    file = File.read('mock-api/get-server-ip-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/firewall_policies/FIREWALL-ID/server_ips/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @firewall.ip(firewall_id: 'FIREWALL-ID', ip_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_ips

    # Read in mock JSON
    file = File.read('mock-api/assign-ip-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/firewall_policies/#{data['id']}/server_ips"},
      {:body => JSON.generate(data), :status => 202})
    
    ip1 = '<IP-ID>'

    ips = [ip1]

    response = @firewall.add_ips(firewall_id: data['id'], ips: ips)

    # Assertions
    assert_equal response['server_ips'][0]['id'], data['server_ips'][0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_ip

    # Read in mock JSON
    file = File.read('mock-api/remove-ip-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/firewall_policies/#{data['id']}/server_ips/IP-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @firewall.remove_ip(firewall_id: data['id'], ip_id: 'IP-ID')

    # Assertions
    assert_equal response['server_ips'].length, 0

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_rules

    # Read in mock JSON
    file = File.read('mock-api/list-fp-rules.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/firewall_policies/FIREWALL-ID/rules"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @firewall.rules(firewall_id: 'FIREWALL-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_rule

    # Read in mock JSON
    file = File.read('mock-api/get-fp-rule.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/firewall_policies/FIREWALL-ID/rules/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @firewall.rule(firewall_id: 'FIREWALL-ID', rule_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_rules

    # Read in mock JSON
    file = File.read('mock-api/add-rule-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/firewall_policies/#{data['id']}/rules"},
      {:body => JSON.generate(data), :status => 202})
    
    rule2 = {
      'protocol' => 'TCP',
      'port_from' => 90,
      'port_to' => 90,
      'source' => '0.0.0.0'
    }

    rules = [rule2]

    response = @firewall.add_rules(firewall_id: data['id'], rules: rules)

    # Assertions
    assert_equal response['rules'][1]['id'], data['rules'][1]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_rule

    # Read in mock JSON
    file = File.read('mock-api/delete-rule-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/firewall_policies/#{data['id']}/rules/RULE-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @firewall.remove_rule(firewall_id: data['id'], rule_id: 'RULE-ID')

    # Assertions
    assert_equal response['rules'].length, 2

    # Clear out stubs
    Excon.stubs.clear

  end


end