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
puts load_balancer.wait_for



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
puts firewall.wait_for



### Create a server
server = OneAndOne::Server.new

server1 = server.create(name: 'Example App Server',
  fixed_instance_id: '65929629F35BBFBA63022008F773F3EB',
  appliance_id: '6C902E5899CC6F7ED18595EBEB542EE1',
  datacenter_id: '5091F6D8CBFEF9C26ACE957C652D5D49')

# Wait for server to deploy
puts "\nCreating server...\n"
puts server.wait_for



### Add the load balancer to the new IP
response = server.add_load_balancer(ip_id: server.first_ip['id'],
  load_balancer_id: load_balancer.id)

# Wait for load balancer to be added
puts "\nAdding load balancer to server IP...\n"
puts server.wait_for



### Add the firewall policy to the new IP
response = server.add_firewall(ip_id: server.first_ip['id'],
  firewall_id: firewall.id)

# Wait for firewall policy to be added
puts "\nAdding firewall policy to server IP...\n"
puts server.wait_for
puts "\nEverything looks good!"



### Cleanup
puts "\nLet's clean up the mess we just made.\n"

puts "\nDeleting server...\n"
server.delete
puts "Success!\n"

puts "\nDeleting firewall policy...\n"
firewall.delete
puts "Success!\n"

puts "\nDeleting load balancer...\n"
load_balancer.delete
puts "Success!\n"

puts "\nAll done!\n"
