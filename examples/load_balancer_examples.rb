# List all load balancers on your account
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.list

puts JSON.pretty_generate(response)



# Create a load balancer
load_balancer = OneAndOne::LoadBalancer.new()

rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

response = load_balancer.create(name: 'Test LB', description: 'Example Desc',
  health_check_test: 'TCP', health_check_interval: 40, persistence: true,
  persistence_time: 1200, method: 'ROUND_ROBIN', rules: rules)

puts JSON.pretty_generate(response)



# Return information about a load balancer
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.get(load_balancer_id: '<LOAD-BALANCER-ID>')

puts JSON.pretty_generate(response)



# Modify a load balancer
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.modify(load_balancer_id: '<LOAD-BALANCER-ID>',
  name: 'New Name')

puts JSON.pretty_generate(response)



# Delete a load balancer
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.delete(load_balancer_id: '<LOAD-BALANCER-ID>')

puts JSON.pretty_generate(response)



# List the IP's assigned to a load balancer
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.ips(load_balancer_id: '<LOAD-BALANCER-ID>')

puts JSON.pretty_generate(response)



# Returns information about an IP assigned to the load balancer
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.ip(load_balancer_id: '<LOAD-BALANCER-ID>',
  ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Remove a load balancer from an IP
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.remove_ip(load_balancer_id: '<LOAD-BALANCER-ID>',
  ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Add a load balancer to IP's
load_balancer = OneAndOne::LoadBalancer.new()

ip1 = '<IP-ID>'

ips = [ip1]

response = load_balancer.add_ips(load_balancer_id: '<LOAD-BALANCER-ID>',
  ips: ips)

puts JSON.pretty_generate(response)



# List a load balancer's rules
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.rules(load_balancer_id: '<LOAD-BALANCER-ID>')

puts JSON.pretty_generate(response)



# Returns information about a load balancer's rule
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.rule(load_balancer_id: '<LOAD-BALANCER-ID>',
  rule_id: '<RULE-ID>')

puts JSON.pretty_generate(response)



# Add new rules to a load balancer
load_balancer = OneAndOne::LoadBalancer.new()

rule2 = {
  'protocol' => 'TCP',
  'port_balancer' => 90,
  'port_server' => 90,
  'source' => '0.0.0.0'
}

rules = [rule2]

response = load_balancer.add_rules(load_balancer_id: '<LOAD-BALANCER-ID>',
  rules: rules)

puts JSON.pretty_generate(response)



# Remove a load balancer's rule
load_balancer = OneAndOne::LoadBalancer.new()

response = load_balancer.remove_rule(load_balancer_id: '<LOAD-BALANCER-ID>',
  rule_id: '<RULE-ID>')

puts JSON.pretty_generate(response)