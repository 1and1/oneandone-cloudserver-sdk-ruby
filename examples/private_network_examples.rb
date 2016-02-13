require_relative 'oneandone'

OneAndOne.start('<API-TOKEN>')




# List all private networks on your account
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.list

puts JSON.pretty_generate(response)



# Create a private network
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.create(name: 'Test PN')

puts JSON.pretty_generate(response)



# Returns a private network's current specs
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.get(private_network_id: '<PRIVATE-NETWORK-ID>')

puts JSON.pretty_generate(response)



# Modify a private network
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.modify(private_network_id: '<PRIVATE-NETWORK-ID>',
  name: 'New PN Name')

puts JSON.pretty_generate(response)



# Delete a private network
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.delete(private_network_id: '<PRIVATE-NETWORK-ID>')

puts JSON.pretty_generate(response)



# List a private network's servers
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.servers(private_network_id: '<PRIVATE-NETWORK-ID>')

puts JSON.pretty_generate(response)



# Returns information about a private network's server
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.server(private_network_id: '<PRIVATE-NETWORK-ID>',
  server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Remove a private network's server
private_network = OneAndOne::PrivateNetwork.new()

response = private_network.remove_server(private_network_id: '<PRIVATE-NETWORK-ID>',
  server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Add servers to a private network
private_network = OneAndOne::PrivateNetwork.new()

server1 = '<SERVER-ID>'

servers = [server1]

response = private_network.add_servers(private_network_id: '<PRIVATE-NETWORK-ID>',
  servers: servers)

puts JSON.pretty_generate(response)