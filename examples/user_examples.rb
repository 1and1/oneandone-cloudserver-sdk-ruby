# List all users on your account
user = OneAndOne::User.new()

response = user.list

puts JSON.pretty_generate(response)



# Create a new user
user = OneAndOne::User.new()

response = user.create(name: 'TestUser', email: 'test@example.com',
  password: 'testpass')

puts JSON.pretty_generate(response)



# Return a user's current specs
user = OneAndOne::User.new()

response = user.get(user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Modify a user account
user = OneAndOne::User.new()

response = user.modify(user_id: '<USER-ID>', description: 'New Description',
  email: 'newemail@example.com')

puts JSON.pretty_generate(response)



# Delete a user
user = OneAndOne::User.new()

response = user.delete(user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Return a user's API access credentials
user = OneAndOne::User.new()

response = user.api(user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Enable or disable a user's API access
user = OneAndOne::User.new()

response = user.enable_api(user_id: '<USER-ID>', active: true)

puts JSON.pretty_generate(response)



# Return a user's API key
user = OneAndOne::User.new()

response = user.api_key(user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Change a user's API key
user = OneAndOne::User.new()

response = user.change_key(user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# List the IP's from which a user can access the API
user = OneAndOne::User.new()

response = user.ips(user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Add IP's from which a user can access the API
user = OneAndOne::User.new()

ip1 = '1.2.3.4'

ips = [ip1]

response = user.add_ips(user_id: '<USER-ID>', ips: ips)

puts JSON.pretty_generate(response)



# Remove API access for an IP
user = OneAndOne::User.new()

ip1 = '1.2.3.4'

response = user.remove_ip(user_id: '<USER-ID>', ip: ip1)

puts JSON.pretty_generate(response)