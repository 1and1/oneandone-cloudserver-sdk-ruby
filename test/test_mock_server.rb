require_relative '../lib/oneandone'
require 'minitest/autorun'

class TestServer < Minitest::Test
  def setup
    
    OneAndOne.start('TEST-API-KEY')
    @server = OneAndOne::Server.new(test: true)

  end

  
  def test_list
    
    # Read in mock JSON
    file = File.read('mock-api/list-servers.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/servers'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.list

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create

    # Read in mock JSON
    file = File.read('mock-api/create-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post, :path => '/v1/servers'},
      {:body => JSON.generate(data), :status => 202})

    hdd1 = {
      'size' => 120,
      'is_main' => true
    }

    hdds = [hdd1]
    
    response = @server.create(name: 'My server', vcore: 1,
      cores_per_processor: 1, ram: 1, appliance_id: '<IMAGE-ID>', hdds: hdds,
      datacenter_id: 'D0F6D8C8ED29D3036F94C27BBB7BAD36', rsa_key: '<PUB-KEY>')

    # Assertions
    assert_equal response['name'], 'My server'
    assert_equal response['datacenter']['country_code'], 'US'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_list_fixed

    # Read in mock JSON
    file = File.read('mock-api/fixed-server-flavors.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get, :path => '/v1/servers/fixed_instance_sizes'},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.list_fixed

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get_fixed

    # Read in mock JSON
    file = File.read('mock-api/get-fixed-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/fixed_instance_sizes/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.get_fixed(fixed_instance_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get

    # Read in mock JSON
    file = File.read('mock-api/get-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.get(server_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify

    # Read in mock JSON
    file = File.read('mock-api/modify-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/servers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.modify(server_id: data['id'], name: data['name'])

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete

    # Read in mock JSON
    file = File.read('mock-api/delete-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete, :path => "/v1/servers/#{data['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.delete(server_id: data['id'])

    # Assertions
    assert_equal response['name'], data['name']
    assert_equal response['status']['state'], 'REMOVING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_hardware

    # Read in mock JSON
    file = File.read('mock-api/get-hardware.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/#{data['id']}/hardware"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.hardware(server_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']
    assert_equal response['vcore'], 1

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify_hardware

    # Read in mock JSON
    file = File.read('mock-api/modify-server-hardware.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put, :path => "/v1/servers/#{data['id']}/hardware"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.modify_hardware(server_id: data['id'],
      vcore: data['hardware']['vcore'])

    # Assertions
    assert_equal response['hardware']['vcore'], data['hardware']['vcore']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_hdds

    # Read in mock JSON
    file = File.read('mock-api/list-hdds.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/hardware/hdds"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.hdds(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response[0]['id'], data[0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_hdds

    # Read in mock JSON
    file = File.read('mock-api/add-hdd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post,
      :path => "/v1/servers/#{data['id']}/hardware/hdds"},
      {:body => JSON.generate(data), :status => 202})

    hdd2 = {
      'size' => 20,
      'is_main' => false
    }

    hdds = [hdd2]
    
    response = @server.add_hdds(server_id: data['id'], hdds: hdds)

    # Assertions
    assert_equal response['hardware']['hdds'][1]['size'], 20

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_get_hdd

    # Read in mock JSON
    file = File.read('mock-api/get-hdd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/hardware/hdds/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.get_hdd(server_id: 'SERVER-ID', hdd_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_modify_hdd

    # Read in mock JSON
    file = File.read('mock-api/modify-server-hdd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put,
      :path => "/v1/servers/#{data['id']}/hardware/hdds/#{data['hardware']['hdds'][1]['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.modify_hdd(server_id: data['id'],
      hdd_id: data['hardware']['hdds'][1]['id'], size: 20)

    # Assertions
    assert_equal response['hardware']['hdds'][1]['size'], 20

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete_hdd

    # Read in mock JSON
    file = File.read('mock-api/remove-hdd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/hardware/hdds/#{data['hardware']['hdds'][1]['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.delete_hdd(server_id: data['id'],
      hdd_id: data['hardware']['hdds'][1]['id'])

    # Assertions
    assert_equal response['status']['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_image

    # Read in mock JSON
    file = File.read('mock-api/get-server-image.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/image"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.image(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response['name'], 'centos7-64std'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_install_image

    # Read in mock JSON
    file = File.read('mock-api/reinstall-image.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put,
      :path => "/v1/servers/#{data['id']}/image"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.install_image(server_id: data['id'],
      image_id: data['image']['id'])

    # Assertions
    assert_equal response['image']['name'], 'centos7-64std'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ips

    # Read in mock JSON
    file = File.read('mock-api/list-server-ips.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/ips"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.ips(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response[0]['ip'], '10.5.135.140'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_ip

    # Read in mock JSON
    file = File.read('mock-api/add-server-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post,
      :path => "/v1/servers/#{data['id']}/ips"},
      {:body => JSON.generate(data), :status => 201})
    
    response = @server.add_ip(server_id: data['id'])

    # Assertions
    assert_equal response['ips'][1]['ip'], '10.4.141.161'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_ip

    # Read in mock JSON
    file = File.read('mock-api/get-server-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/ips/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.ip(server_id: 'SERVER-ID', ip_id: data['id'])

    # Assertions
    assert_equal response['id'], data['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_release_ip

    # Read in mock JSON
    file = File.read('mock-api/remove-server-ip.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/ips/#{data['ips'][0]['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.release_ip(server_id: data['id'],
      ip_id: data['ips'][0]['id'])

    # Assertions
    assert_equal response['ips'][0]['id'], data['ips'][0]['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_firewall

    # Read in mock JSON
    file = File.read('mock-api/add-firewall.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put,
      :path => "/v1/servers/#{data['id']}/ips/#{data['ips'][0]['id']}/firewall_policy"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.add_firewall(server_id: data['id'],
      ip_id: data['ips'][0]['id'],
      firewall_id: data['ips'][0]['firewall_policy']['id'])

    # Assertions
    assert_equal response['ips'][0]['firewall_policy']['id'],
    data['ips'][0]['firewall_policy']['id']

    # Clear out stubs
    Excon.stubs.clear    

  end


  def test_firewall

    # Read in mock JSON
    file = File.read('mock-api/get-server-ip-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/ips/IP-ID/firewall_policy"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.firewall(server_id: 'SERVER-ID',
      ip_id: 'IP-ID')

    # Assertions
    assert_equal response['id'], '3C4F21EDFEEDD6ABB728EA5CE684E1AF'

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_remove_firewall

    # Read in mock JSON
    file = File.read('mock-api/remove-ip-fp.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/ips/IP-ID/firewall_policy"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.remove_firewall(server_id: data['id'],
      ip_id: 'IP-ID')

    # Assertions
    assert_equal response['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_load_balancers

    # Read in mock JSON
    file = File.read('mock-api/list-server-lbs.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/ips/IP-ID/load_balancers"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.load_balancers(server_id: 'SERVER-ID',
      ip_id: 'IP-ID')

    # Assertions
    assert_equal response[0]['id'], '37E2FDEB2945990CEE4B7927FB1ED425'

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_add_load_balancer

    # Read in mock JSON
    file = File.read('mock-api/add-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post,
      :path => "/v1/servers/#{data['id']}/ips/#{data['ips'][0]['id']}/load_balancers"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.add_load_balancer(server_id: data['id'],
      ip_id: data['ips'][0]['id'],
      load_balancer_id: data['ips'][0]['load_balancers'][0]['id'])

    # Assertions
    assert_equal response['ips'][0]['load_balancers'][0]['id'],
    data['ips'][0]['load_balancers'][0]['id']

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_remove_load_balancer

    # Read in mock JSON
    file = File.read('mock-api/remove-lb.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/ips/#{data['ips'][0]['id']}/load_balancers/LOAD-BALANCER-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.remove_load_balancer(server_id: data['id'],
      ip_id: data['ips'][0]['id'], load_balancer_id: 'LOAD-BALANCER-ID')

    # Assertions
    assert_equal response['ips'][0]['load_balancers'], []

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_status

    # Read in mock JSON
    file = File.read('mock-api/get-server-status.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/status"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.status(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response['state'], 'POWERED_ON'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_change_status

    # Read in mock JSON
    file = File.read('mock-api/change-server-status.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put,
      :path => "/v1/servers/#{data['id']}/status/action"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.change_status(server_id: data['id'],
      action: 'POWER_OFF',
      method: 'SOFTWARE')

    # Assertions
    assert_equal response['status']['state'], 'POWERING_OFF'

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_dvd

    # Read in mock JSON
    file = File.read('mock-api/get-server-dvd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/dvd"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.dvd(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response['name'], 'Windows 2012 - 64 bits'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_load_dvd

    # Read in mock JSON
    file = File.read('mock-api/load-dvd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put,
      :path => "/v1/servers/#{data['id']}/dvd"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.load_dvd(server_id: data['id'], dvd_id: 'DVD-ID')

    # Assertions
    assert_equal response['dvd'], nil

    # Clear out stubs
    Excon.stubs.clear 

  end


  def test_eject_dvd

    # Read in mock JSON
    file = File.read('mock-api/eject-dvd.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/dvd"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.eject_dvd(server_id: data['id'])

    # Assertions
    assert_equal response['status']['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_private_networks

    # Read in mock JSON
    file = File.read('mock-api/list-server-pns.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/private_networks"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.private_networks(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response[0]['name'], 'New private network 1'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_private_network

    # Read in mock JSON
    file = File.read('mock-api/get-server-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/#{data['servers'][0]['id']}/private_networks/#{data['id']}"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.private_network(server_id: data['servers'][0]['id'],
      private_network_id: data['id'])

    # Assertions
    assert_equal response['name'], 'New private network 1'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_add_private_network

    # Read in mock JSON
    file = File.read('mock-api/add-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post,
      :path => "/v1/servers/#{data['id']}/private_networks"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.add_private_network(server_id: data['id'],
      private_network_id: 'PRIVATE-NETWORK-ID')

    # Assertions
    assert_equal response['private_networks'], nil

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_remove_private_network

    # Read in mock JSON
    file = File.read('mock-api/remove-pn.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/private_networks/PRIVATE-NETWORK-ID"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.remove_private_network(server_id: data['id'],
      private_network_id: 'PRIVATE-NETWORK-ID')

    # Assertions
    assert_equal response['private_networks'][0]['name'], 'New private network 1'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_create_snapshot

    # Read in mock JSON
    file = File.read('mock-api/create-snapshot.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post,
      :path => "/v1/servers/#{data['id']}/snapshots"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.create_snapshot(server_id: data['id'])

    # Assertions
    assert_equal response['snapshot']['id'], data['snapshot']['id']

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_snapshot

    # Read in mock JSON
    file = File.read('mock-api/list-snapshots.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :get,
      :path => "/v1/servers/SERVER-ID/snapshots"},
      {:body => JSON.generate(data), :status => 200})
    
    response = @server.snapshot(server_id: 'SERVER-ID')

    # Assertions
    assert_equal response[0]['id'], 'B77E19E062D5818532EFF11C747BD104'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_restore_snapshot

    # Read in mock JSON
    file = File.read('mock-api/restore-snapshot.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :put,
      :path => "/v1/servers/#{data['id']}/snapshots/#{data['snapshot']['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.restore_snapshot(server_id: data['id'],
      snapshot_id: data['snapshot']['id'])

    # Assertions
    assert_equal response['status']['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_delete_snapshot

    # Read in mock JSON
    file = File.read('mock-api/delete-snapshot.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :delete,
      :path => "/v1/servers/#{data['id']}/snapshots/#{data['snapshot']['id']}"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.delete_snapshot(server_id: data['id'],
      snapshot_id: data['snapshot']['id'])

    # Assertions
    assert_equal response['status']['state'], 'CONFIGURING'

    # Clear out stubs
    Excon.stubs.clear

  end


  def test_clone

    # Read in mock JSON
    file = File.read('mock-api/clone-server.json')
    data = JSON.parse(file)

    # Create stub and perform call
    Excon.stub({:method => :post,
      :path => "/v1/servers/SERVER-ID/clone"},
      {:body => JSON.generate(data), :status => 202})
    
    response = @server.clone(server_id: 'SERVER-ID',
      name: data['name'])

    # Assertions
    assert_equal response['name'], data['name']

    # Clear out stubs
    Excon.stubs.clear

  end


end