# List all VPN's on your account
vpn = OneAndOne::Vpn.new()

response = vpn.list

puts JSON.pretty_generate(response)



# Create a new VPN
vpn = OneAndOne::Vpn.new()

response = vpn.create(name: 'Example VPN')

puts JSON.pretty_generate(response)

## Wait for VPN to deploy before performing other actions ## 
puts "\nCreating VPN, please wait..."
puts vpn.wait_for



# Retrieve the current specs for a VPN
vpn = OneAndOne::Vpn.new()

response = vpn.get(vpn_id: '<VPN-ID>')

puts JSON.pretty_generate(response)



# Modify a VPN
vpn = OneAndOne::Vpn.new()

response = vpn.modify(vpn_id: '<VPN-ID>', name: 'New Name')

puts JSON.pretty_generate(response)



# Delete a VPN
vpn = OneAndOne::Vpn.new()

response = vpn.delete(vpn_id: '<VPN-ID>')

puts JSON.pretty_generate(response)



# Download a VPN's config file
vpn = OneAndOne::Vpn.new()

response = vpn.download_config(vpn_id: '<VPN-ID>')

puts JSON.pretty_generate(response)

