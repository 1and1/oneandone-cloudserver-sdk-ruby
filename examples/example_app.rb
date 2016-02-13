require_relative '../lib/oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API key



### Create load balancer
load_balancer = OneAndOne::LoadBalancer.new

rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

lb1 = load_balancer.create(name: 'Example App LB', description: 'Example Desc',
  health_check_test: 'TCP', health_check_interval: 40, persistence: true,
  persistence_time: 1200, method: 'ROUND_ROBIN', rules: rules)

# Wait for load balancer to deploy
puts "\nCreating load balancer...\n"
load_balancer.wait_for



### Create firewall policy
firewall = OneAndOne::Firewall.new

rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

fp1 = firewall.create(name: 'Example App Firewall', description: 'Example Desc',
  rules: rules)

# Wait for firewall policy to deploy
puts "\nCreating firewall policy...\n"
firewall.wait_for



### Create a server
server = OneAndOne::Server.new

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

server1 = server.create(name: 'Example App Server', vcore: 1,
  cores_per_processor: 1, ram: 1,
  appliance_id: '<IMAGE-ID>', hdds: hdds)

# Wait for server to deploy
puts "\nCreating server...\n"
server.wait_for



### Add a new IP to the server
puts "\nAdding an IP to the server...\n"
response = server.add_ip
new_ip = response['ips'][1]['id']



### Add the load balancer to the new IP
response = server.add_load_balancer(ip_id: new_ip,
  load_balancer_id: load_balancer.id)

# Wait for load balancer to be added
puts "\nAdding load balancer to new server IP...\n"
server.wait_for



### Add the firewall policy to the new IP
response = server.add_firewall(ip_id: new_ip,
  firewall_id: firewall.id)

# Wait for firewall policy to be added
puts "\nAdding firewall policy to new server IP...\n"
server.wait_for
puts "\nEverything looks good!"



### Cleanup
puts "\nLet's clean up the mess we just made.\n"

puts "\nDeleting server...\n"
response = server.delete
puts "Success!\n"

puts "\nDeleting load balancer...\n"
response = load_balancer.delete
puts "Success!\n"

puts "\nDeleting firewall policy...\n"
response = firewall.delete
puts "Success!\n"

puts "\nAll done!\n"
