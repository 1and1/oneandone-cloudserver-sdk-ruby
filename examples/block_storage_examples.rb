OneAndOne.start('<API-TOKEN>')

block_storage = OneAndOne::BlockStorage.new

# Create a block storage
response = block_storage.create(name: 'My block storage',
                                description: 'My block storage description',
                                size: 20,
                                datacenter_id: '908DC2072407C94C8054610AD5A53B8C')

puts JSON.pretty_generate(response)


# List all block storages on your account
response = block_storage.list

puts JSON.pretty_generate(response)


# Retrieve a single block storage
response = block_storage.get(block_storage_id: '<BLOCK-STORAGE-ID>')

puts JSON.pretty_generate(response)


# Modify a block storage
response = block_storage.modify(block_storage_id: '<BLOCK-STORAGE-ID>',
                                name: 'Test Block Storage Rename',
                                description: 'Test Block Storage Description Update')

puts JSON.pretty_generate(response)


# Attach a block storage to a server
response = block_storage.attach_server(block_storage_id: '<BLOCK-STORAGE-ID>',
                                       server_id: '<SERVER-ID>')

puts JSON.pretty_generate(response)


# Detach a block storage from a server
response = block_storage.detach_server(block_storage_id: '<BLOCK-STORAGE-ID>')

puts JSON.pretty_generate(response)


# Delete a block storage
response = block_storage.delete(block_storage_id: '<BLOCK-STORAGE-ID>')

puts JSON.pretty_generate(response)
