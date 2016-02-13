require_relative 'oneandone'

OneAndOne.start('<API-TOKEN>')




# List all firewall policies on your account
firewall = OneAndOne::Firewall.new()

response = firewall.list

puts JSON.pretty_generate(response)



# Create a firewall policy
firewall = OneAndOne::Firewall.new()

rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

response = firewall.create(name: 'Test Firewall', description: 'Example Desc',
  rules: rules)

puts JSON.pretty_generate(response)



# Retrieve a firewall policy's current specs
firewall = OneAndOne::Firewall.new()

response = firewall.get(firewall_id: '<FIREWALL-ID>')

puts JSON.pretty_generate(response)



# Modify a firewall policy
firewall = OneAndOne::Firewall.new()

response = firewall.modify(firewall_id: '<FIREWALL-ID>', name: 'New Name')

puts JSON.pretty_generate(response)



# Delete a firewall policy
firewall = OneAndOne::Firewall.new()

response = firewall.delete(firewall_id: '<FIREWALL-ID>')

puts JSON.pretty_generate(response)



# List the IPs assigned to a firewall policy
firewall = OneAndOne::Firewall.new()

response = firewall.ips(firewall_id: '<FIREWALL-ID>')

puts JSON.pretty_generate(response)



# Retrieve information about an IP assigned to a firewall policy
firewall = OneAndOne::Firewall.new()

response = firewall.ip(firewall_id: '<FIREWALL-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Add IPs to a firewall policy
firewall = OneAndOne::Firewall.new()

ip1 = '<IP-ID>'

ips = [ip1]

response = firewall.add_ips(firewall_id: '<FIREWALL-ID>', ips: ips)

puts JSON.pretty_generate(response)



# Remove a firewall policy's IP
firewall = OneAndOne::Firewall.new()

response = firewall.remove_ip(firewall_id: '<FIREWALL-ID>', ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# List a firewall policy's rules
firewall = OneAndOne::Firewall.new()

response = firewall.rules(firewall_id: '<FIREWALL-ID>')

puts JSON.pretty_generate(response)



# Retrieve information about a firewall policy's rule
firewall = OneAndOne::Firewall.new()

response = firewall.rule(firewall_id: '<FIREWALL-ID>', rule_id: '<RULE-ID>')

puts JSON.pretty_generate(response)



# Add new rules to a firewall policy
firewall = OneAndOne::Firewall.new()

rule2 = {
  'protocol' => 'TCP',
  'port_from' => 90,
  'port_to' => 90,
  'source' => '0.0.0.0'
}

rules = [rule2]

response = firewall.add_rules(firewall_id: '<FIREWALL-ID>', rules: rules)

puts JSON.pretty_generate(response)



# Remove a rule
firewall = OneAndOne::Firewall.new()

response = firewall.remove_rule(firewall_id: '<FIREWALL-ID>', rule_id: '<RULE-ID>')

puts JSON.pretty_generate(response)