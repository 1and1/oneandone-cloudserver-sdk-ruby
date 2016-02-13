require_relative 'oneandone'

OneAndOne.start('<API-TOKEN>')




# List all shared storages on your account
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.list

puts JSON.pretty_generate(response)



# Create a shared storage
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.create(name: 'Test SS', description: 'Example Desc',
  size: 200)

puts JSON.pretty_generate(response)



# Retrieve a shared storage's current specs
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.get(shared_storage_id: '<SHARED-STORAGE-ID>')

puts JSON.pretty_generate(response)



# Modify a shared storage
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.modify(shared_storage_id: '<SHARED-STORAGE-ID>',
  name: 'Test SS Rename', size: 400)

puts JSON.pretty_generate(response)



# Delete a shared storage
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.delete(shared_storage_id: '<SHARED-STORAGE-ID>')

puts JSON.pretty_generate(response)



# Add servers to a shared storage
shared_storage = OneAndOne::SharedStorage.new()

server1 = {
  'id' => '<SERVER-ID>',
  'rights' => 'RW'
}

servers = [server1]

response = shared_storage.add_servers(shared_storage_id: '<SHARED-STORAGE-ID>',
  servers: servers)

puts JSON.pretty_generate(response)



# List a shared storage's servers
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.servers(shared_storage_id: '<SHARED-STORAGE-ID>')

puts JSON.pretty_generate(response)



# Retrieve information about a shared storage's server
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.server(shared_storage_id: '<SHARED-STORAGE-ID>',
  server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Remove a server from a shared storage
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.remove_server(shared_storage_id: '<SHARED-STORAGE-ID>',
  server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)



# Retrieve the credentials for accessing shared storages
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.access

puts JSON.pretty_generate(response)



# Change the password for accessing shared storages
shared_storage = OneAndOne::SharedStorage.new()

response = shared_storage.change_password(password: 'newpassword22')

puts JSON.pretty_generate(response)