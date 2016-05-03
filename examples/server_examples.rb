# List all servers on your account
server = OneAndOne::Server.new()

response = server.list

puts JSON.pretty_generate(response)



# Create a new server
server = OneAndOne::Server.new()

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example Server', vcore: 1,
  cores_per_processor: 1, ram: 1,
  appliance_id: '<IMAGE-ID>', hdds: hdds)

puts JSON.pretty_generate(response)

## Wait for server to deploy before performing other actions ## 
puts "\nCreating server, please wait..."
server.wait_for



# Create a new server with SSH Key access
server = OneAndOne::Server.new()

pub_key = '<PUB-KEY>'

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example Server', vcore: 1,
  cores_per_processor: 1, ram: 1,
  appliance_id: '<IMAGE-ID>', hdds: hdds, rsa_key: pub_key)

puts JSON.pretty_generate(response)

## Wait for server to deploy before performing other actions ## 
puts "\nCreating server, please wait..."
server.wait_for



# Create a new server with SSH Key access and explicitly declare your datacenter
server = OneAndOne::Server.new()

pub_key = '<PUB-KEY>'
datacenter = '<DATACENTER-ID>'

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Example Server', vcore: 1,
  cores_per_processor: 1, ram: 1,
  appliance_id: '<IMAGE-ID>', hdds: hdds, rsa_key: pub_key,
  datacenter_id: datacenter)

puts JSON.pretty_generate(response)

## Wait for server to deploy before performing other actions ## 
puts "\nCreating server, please wait..."
server.wait_for



# List all fixed server options
server = OneAndOne::Server.new()

response = server.list_fixed

puts JSON.pretty_generate(response)



# Retrieve information about a fixed server option
server = OneAndOne::Server.new()

response = server.get_fixed(fixed_instance_id: '<FIXED-ID>')

puts JSON.pretty_generate(response)



# Retrieve the current specs for a server
server = OneAndOne::Server.new()

response = server.get(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Modify a server
server = OneAndOne::Server.new()

response = server.modify(server_id: '<SERVER-ID>', name: 'New Name')

puts JSON.pretty_generate(response)



# Delete a server
server = OneAndOne::Server.new()

response = server.delete(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Retrieve a server's current hardware configuration
server = OneAndOne::Server.new()

response = server.hardware(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Modify a server's hardware configurations
server = OneAndOne::Server.new()

response = server.modify_hardware(server_id: '<SERVER-ID>', ram: 2)

puts JSON.pretty_generate(response)



# List a server's hdds
server = OneAndOne::Server.new()

response = server.hdds(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Add hdds to a server
server = OneAndOne::Server.new()

hdd2 = {
  'size' => 100,
  'is_main' => false
}

hdds = [hdd2]

response = server.add_hdds(server_id: '<SERVER-ID>', hdds: hdds)

puts JSON.pretty_generate(response)



# Retrieve a server's hdd
server = OneAndOne::Server.new()

response = server.get_hdd(server_id: '<SERVER-ID>', hdd_id: '<HDD-ID>')

puts JSON.pretty_generate(response)



# Modify a server's hdd
server = OneAndOne::Server.new()

response = server.modify_hdd(server_id: '<SERVER-ID>', hdd_id: '<HDD-ID>',
  size: 140)

puts JSON.pretty_generate(response)



# Delete a server's hdd
server = OneAndOne::Server.new()

response = server.delete_hdd(server_id: '<SERVER-ID>', hdd_id: '<HDD-ID>')

puts JSON.pretty_generate(response)



# Retrieve information about a server's image
server = OneAndOne::Server.new()

response = server.image(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Install an image onto a server
server = OneAndOne::Server.new()

response = server.install_image(server_id: '<SERVER-ID>', image_id: '<IMAGE-ID>')

puts JSON.pretty_generate(response)



# List a servers IPs
server = OneAndOne::Server.new()

response = server.ips(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Add an IP to a server
server = OneAndOne::Server.new()

response = server.add_ip(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Retrieve a server's IP
server = OneAndOne::Server.new()

response = server.ip(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Release a server's IP
server = OneAndOne::Server.new()

response = server.release_ip(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Add a firewall to a server
server = OneAndOne::Server.new()

response = server.add_firewall(server_id: '<SERVER-ID>', ip_id: '<IP-ID>',
  firewall_id: '<FIREWALL-ID>')

puts JSON.pretty_generate(response)



# Retrieve a server IP's firewall
server = OneAndOne::Server.new()

response = server.firewall(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Remove a server IP's firewall
server = OneAndOne::Server.new()

response = server.remove_firewall(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# List a server IP's load balancers
server = OneAndOne::Server.new()

response = server.load_balancers(server_id: '<SERVER-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Add a load balancer to a server's IP
server = OneAndOne::Server.new()

response = server.add_load_balancer(server_id: '<SERVER-ID>', ip_id: '<IP-ID>',
  load_balancer_id: '<LOAD-BALANCER-ID>')

puts JSON.pretty_generate(response)



# Remove a load balancer from a server's IP
server = OneAndOne::Server.new()

response = server.remove_load_balancer(server_id: '<SERVER-ID>', ip_id: '<IP-ID>',
  load_balancer_id: '<LOAD-BALANCER-ID>')

puts JSON.pretty_generate(response)



# Retrieve a server's current status
server = OneAndOne::Server.new()

response = server.status(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Change a server's status
server = OneAndOne::Server.new()

response = server.change_status(server_id: '<SERVER-ID>', action: 'REBOOT',
  method: 'SOFTWARE')

puts JSON.pretty_generate(response)



# Retrieve a server's DVD
server = OneAndOne::Server.new()

response = server.dvd(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Eject a server's DVD
server = OneAndOne::Server.new()

response = server.eject_dvd(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Load a DVD into a server
server = OneAndOne::Server.new()

response = server.load_dvd(server_id: '<SERVER-ID>', dvd_id: '<DVD-ID>')

puts JSON.pretty_generate(response)



# List a server's private networks
server = OneAndOne::Server.new()

response = server.private_networks(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Retrieve information about a server's private network
server = OneAndOne::Server.new()

response = server.private_network(server_id: '<SERVER-ID>',
  private_network_id: '<PRIVATE-NETWORK-ID>')

puts JSON.pretty_generate(response)



# Add a server to a private network
server = OneAndOne::Server.new()

response = server.add_private_network(server_id: '<SERVER-ID>',
  private_network_id: '<PRIVATE-NETWORK-ID>')

puts JSON.pretty_generate(response)



# Remove a server from a private network
server = OneAndOne::Server.new()

response = server.remove_private_network(server_id: '<SERVER-ID>',
  private_network_id: '<PRIVATE-NETWORK-ID>')

puts JSON.pretty_generate(response)



# Create a server snapshot
server = OneAndOne::Server.new()

response = server.create_snapshot(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Retrieve a server's snapshot
server = OneAndOne::Server.new()

response = server.snapshot(server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Restore a server's snapshot
server = OneAndOne::Server.new()

response = server.restore_snapshot(server_id: '<SERVER-ID>',
  snapshot_id: '<SNAPSHOT-ID>')

puts JSON.pretty_generate(response)



# Delete a server's snapshot
server = OneAndOne::Server.new()

response = server.delete_snapshot(server_id: '<SERVER-ID>',
  snapshot_id: '<SNAPSHOT-ID>')

puts JSON.pretty_generate(response)



# Clone a server
server = OneAndOne::Server.new()

response = server.clone(server_id: '<SERVER-ID>',
  name: 'My Server Clone')

puts JSON.pretty_generate(response)