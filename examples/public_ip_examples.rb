# List all public IPs on your account
public_ip = OneAndOne::PublicIP.new()

response = public_ip.list

puts JSON.pretty_generate(response)



# Create a public IP
public_ip = OneAndOne::PublicIP.new()

response = public_ip.create(reverse_dns: 'example.com')

puts JSON.pretty_generate(response)



# Returns a public IP's current specs
public_ip = OneAndOne::PublicIP.new()

response = public_ip.get(ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)



# Modify a public IP
public_ip = OneAndOne::PublicIP.new()

response = public_ip.modify(ip_id: '<IP-ID>', reverse_dns: 'newexample.com')

puts JSON.pretty_generate(response)



# Delete a public IP
public_ip = OneAndOne::PublicIP.new()

response = public_ip.delete(ip_id: '<IP-ID>')

puts JSON.pretty_generate(response)