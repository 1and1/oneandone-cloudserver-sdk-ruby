require_relative '../lib/oneandone'

token =ENV['ONEANDONE_TOKEN']
OneAndOne.start(token)

appliance = OneAndOne::ServerAppliance.new()

appliances = appliance.list(q:'ubuntu')

for aplnc in appliances
  if aplnc['type'] == "IMAGE"
    break
  end
end

# Create a new server
server = OneAndOne::Server.new()

hdd1 = {
    'size' => 120,
    'is_main' => true
}

hdds = [hdd1]

response = server.create(name: 'Ruby Example Server3', vcore: 1,
                         cores_per_processor: 1, ram: 1,
                         appliance_id: aplnc['id'], hdds: hdds)

puts JSON.pretty_generate(response)
## Wait for server to deploy before performing other actions ##
puts "\nCreating server, please wait..."
server.wait_for

serverResp = server.get

# Create a firewall policy
firewall = OneAndOne::Firewall.new()

rule1 = {
    'protocol' => 'TCP',
    'port_from' => 80,
    'port_to' => 80,
    'source' => '0.0.0.0'
}

rules = [rule1]

fwResp = firewall.create(name: 'Ruby Test Firewall3', description: 'Example Desc',
                           rules: rules)

puts JSON.pretty_generate(fwResp)

firewall.wait_for


# Add IPs to a firewall policy
ip1 = serverResp['ips'][0]['id']

ips = [ip1]

response = firewall.add_ips(firewall_id: fwResp['id'], ips: ips)

puts JSON.pretty_generate(response)

# List all firewall policies on your account
response = firewall.list

puts JSON.pretty_generate(response)

# Retrieve a firewall policy's current specs
response = firewall.get(firewall_id: fwResp['id'])

puts JSON.pretty_generate(response)


# Modify a firewall policy
response = firewall.modify(firewall_id: fwResp['id'], name: 'New Name')

puts JSON.pretty_generate(response)

# List the IPs assigned to a firewall policy
response = firewall.ips(firewall_id: fwResp['id'])

puts JSON.pretty_generate(response)



# Retrieve information about an IP assigned to a firewall policy
response = firewall.ip(firewall_id: fwResp['id'], ip_id: ip1)

puts JSON.pretty_generate(response)

# Add new rules to a firewall policy
rule2 = {
    'protocol' => 'TCP',
    'port' => 90,
    'action' => 'allow',
    'source' => '0.0.0.0'
}

rules = [rule2]

ruleResp = firewall.add_rules(firewall_id: fwResp['id'], rules: rules)

puts JSON.pretty_generate(ruleResp)


# List a firewall policy's rules
response = firewall.rules(firewall_id: fwResp['id'])

puts JSON.pretty_generate(response)


# Retrieve information about a firewall policy's rule
response = firewall.rule(firewall_id: fwResp['id'], rule_id: response[0]['id'])

puts JSON.pretty_generate(response)

# Remove a rule
response = firewall.remove_rule(firewall_id: fwResp['id'], rule_id: response['id'])

puts JSON.pretty_generate(response)

server.wait_for
server.delete(server_id: serverResp['id'])
server.wait_deleted(server_id: serverResp['id'])

firewall.wait_for
# Delete a firewall policy
firewall.delete(firewall_id: fwResp['id'])