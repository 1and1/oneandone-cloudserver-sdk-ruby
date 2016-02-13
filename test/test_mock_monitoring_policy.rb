require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestMonitoringPolicy < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @monitoring_policy = OneAndOne::MonitoringPolicy.new(test: true)

  end


  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-mps.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/monitoring_policies'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/monitoring_policies'},
      {:body => JSON.generate(data), :status => 202})
    
    ### Create threshold limits
    thresholds = {
      'cpu' => {
        'warning' => {
          'value' => 90,
          'alert' => false
        },
        'critical' => {
          'value' => 95,
          'alert' => false
        }
      },
      'ram' => {
        'warning' => {
          'value' => 90,
          'alert' => false
        },
        'critical' => {
          'value' => 95,
          'alert' => false
        }
      },
      'disk' => {
        'warning' => {
          'value' => 90,
          'alert' => false
        },
        'critical' => {
          'value' => 95,
          'alert' => false
        }
      },
      'transfer' => {
        'warning' => {
          'value' => 1000,
          'alert' => false
        },
        'critical' => {
          'value' => 2000,
          'alert' => false
        }
      },
      'internal_ping' => {
        'warning' => {
          'value' => 50,
          'alert' => false
        },
        'critical' => {
          'value' => 100,
          'alert' => false
        }
      }
    }

    ### Add ports
    port1 = {
      'protocol' => 'TCP',
      'port' => 80,
      'alert_if' => 'NOT_RESPONDING',
      'email_notification' => true
    }

    ports = [port1]

    ### Add processes
    process1 = {
      'process' => 'test',
      'alert_if' => 'NOT_RUNNING',
      'email_notification' => true
    }

    processes = [process1]

    response = @monitoring_policy.create(name: 'Test Monitoring Policy',
      email: 'test@example.com', agent: true, thresholds: thresholds,
      ports: ports, processes: processes)

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.get(monitoring_policy_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/monitoring_policies/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    new_thresholds = {
      'cpu' => {
        'warning' => {
          'value' => 80,
          'alert' => false
        },
        'critical' => {
          'value' => 85,
          'alert' => false
        }
      },
      'ram' => {
        'warning' => {
          'value' => 80,
          'alert' => false
        },
        'critical' => {
          'value' => 85,
          'alert' => false
        }
      },
      'disk' => {
        'warning' => {
          'value' => 80,
          'alert' => false
        },
        'critical' => {
          'value' => 85,
          'alert' => false
        }
      },
      'transfer' => {
        'warning' => {
          'value' => 750,
          'alert' => false
        },
        'critical' => {
          'value' => 1250,
          'alert' => false
        }
      },
      'internal_ping' => {
        'warning' => {
          'value' => 75,
          'alert' => true
        },
        'critical' => {
          'value' => 90,
          'alert' => true
        }
      }
    }

    response = @monitoring_policy.modify(monitoring_policy_id: data['id'],
      name: 'New Name', thresholds: new_thresholds)

    # Assertions
    assert_equal response['id'], data['id']
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/monitoring_policies/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @monitoring_policy.delete(monitoring_policy_id: data['id'])

    # Assertions
    assert_equal response['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ports

    # Read in mock JSON
    file = File.read('mock-api/list-mp-ports.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/MP-ID/ports"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.ports(monitoring_policy_id: 'MP-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_ports

    # Read in mock JSON
    file = File.read('mock-api/add-port-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/monitoring_policies/#{data['id']}/ports"},
      {:body => JSON.generate(data), :status => 202})

    port2 = {
      'protocol' => 'TCP',
      'port' => 90,
      'alert_if' => 'NOT_RESPONDING',
      'email_notification' => true
    }

    ports = [port2]
    
    response = @monitoring_policy.add_ports(monitoring_policy_id: data['id'],
      ports: ports)

    # Assertions
    assert_equal response['ports'].length, 1

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_port

    # Read in mock JSON
    file = File.read('mock-api/get-mp-port.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/MP-ID/ports/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.port(monitoring_policy_id: 'MP-ID',
      port_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete_port

    # Read in mock JSON
    file = File.read('mock-api/remove-port-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/monitoring_policies/#{data['id']}/ports/PORT-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @monitoring_policy.delete_port(monitoring_policy_id: data['id'],
      port_id: 'PORT-ID')

    # Assertions
    assert_equal response['ports'], []

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify_port

    # Read in mock JSON
    file = File.read('mock-api/modify-port-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/monitoring_policies/#{data['id']}/ports/PORT-ID"},
      {:body => JSON.generate(data), :status => 202})

    port = {
      'protocol' => 'TCP',
      'port' => 80,
      'alert_if' => 'RESPONDING',
      'email_notification' => false
    }
    
    response = @monitoring_policy.modify_port(monitoring_policy_id: data['id'],
      port_id: 'PORT-ID', new_port: port)

    # Assertions
    assert_equal response['ports'][0]['port'], '22'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_processes

    # Read in mock JSON
    file = File.read('mock-api/list-mp-processes.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/MP-ID/processes"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.processes(monitoring_policy_id: 'MP-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_process

    # Read in mock JSON
    file = File.read('mock-api/get-mp-process.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/MP-ID/processes/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.process(monitoring_policy_id: 'MP-ID',
      process_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_processes

    # Read in mock JSON
    file = File.read('mock-api/add-process-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/monitoring_policies/MP-ID/processes"},
      {:body => JSON.generate(data), :status => 202})

    process2 = {
      'process' => 'logger',
      'alert_if' => 'NOT_RUNNING',
      'email_notification' => true
    }

    processes = [process2]
    
    response = @monitoring_policy.add_processes(monitoring_policy_id: 'MP-ID',
      processes: processes)

    # Assertions
    assert_equal response.length, 3

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify_process

    # Read in mock JSON
    file = File.read('mock-api/modify-process-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/monitoring_policies/#{data['id']}/processes/PROCESS-ID"},
      {:body => JSON.generate(data), :status => 202})

    process = {
      'process' => 'test',
      'alert_if' => 'RUNNING',
      'email_notification' => false
    }
    
    response = @monitoring_policy.modify_process(monitoring_policy_id: data['id'],
      process_id: 'PROCESS-ID', new_process: process)

    # Assertions
    assert_equal response['processes'][0]['process'], 'test'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete_process

    # Read in mock JSON
    file = File.read('mock-api/remove-process-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/monitoring_policies/#{data['id']}/processes/PROCESS-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @monitoring_policy.delete_process(monitoring_policy_id: data['id'],
      process_id: 'PROCESS-ID')

    # Assertions
    assert_equal response['processes'], []

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_servers

    # Read in mock JSON
    file = File.read('mock-api/list-mp-servers.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/MP-ID/servers"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.servers(monitoring_policy_id: 'MP-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_server

    # Read in mock JSON
    file = File.read('mock-api/get-mp-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => "/v1/monitoring_policies/MP-ID/servers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @monitoring_policy.server(monitoring_policy_id: 'MP-ID',
      server_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_servers

    # Read in mock JSON
    file = File.read('mock-api/add-server-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => "/v1/monitoring_policies/#{data['id']}/servers"},
      {:body => JSON.generate(data), :status => 202})

    server1 = '<SERVER-ID>'

    servers = [server1]
    
    response = @monitoring_policy.add_servers(monitoring_policy_id: data['id'],
      servers: servers)

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_server

    # Read in mock JSON
    file = File.read('mock-api/detach-server-mp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/monitoring_policies/#{data['id']}/servers/SERVER-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @monitoring_policy.remove_server(monitoring_policy_id: data['id'],
      server_id: 'SERVER-ID')

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


end