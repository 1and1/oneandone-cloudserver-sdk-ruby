# List all available roles on your account
role = OneAndOne::Role.new()

response = role.list

puts JSON.pretty_generate(response)



# Create a new role
role = OneAndOne::Role.new()

response = role.create(name: 'Example Role')

puts JSON.pretty_generate(response)



# Retrieve the current specs for a role
role = OneAndOne::Role.new()

response = role.get(role_id: '<ROLE-ID>')

puts JSON.pretty_generate(response)



# Modify a role
role = OneAndOne::Role.new()

response = role.modify(role_id: '<ROLE-ID>', name: 'New Name', state: 'ACTIVE')

puts JSON.pretty_generate(response)



# Delete a role
role = OneAndOne::Role.new()

response = role.delete(role_id: '<ROLE-ID>')

puts JSON.pretty_generate(response)



# List a role's permissions
role = OneAndOne::Role.new()

response = role.permissions(role_id: '<ROLE-ID>')

puts JSON.pretty_generate(response)



# Modify a role's permissions
role = OneAndOne::Role.new()

server_perms = {
  'show' => true,
  'create' => true,
  'delete' => false
}

response = role.modify_permissions(role_id: '<ROLE-ID>', servers: server_perms)

puts JSON.pretty_generate(response)



# List the users assigned to a role
role = OneAndOne::Role.new()

response = role.users(role_id: '<ROLE-ID>')

puts JSON.pretty_generate(response)



# Assign users to a role
role = OneAndOne::Role.new()

users = ['<USER1-ID>', '<USER2-ID>']

response = role.add_users(role_id: '<ROLE-ID>', users: users)

puts JSON.pretty_generate(response)



# Returns information about a user assigned to a role
role = OneAndOne::Role.new()

response = role.get_user(role_id: '<ROLE-ID>', user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Unassign a user from a role
role = OneAndOne::Role.new()

response = role.remove_user(role_id: '<ROLE-ID>', user_id: '<USER-ID>')

puts JSON.pretty_generate(response)



# Clone a role
role = OneAndOne::Role.new()

response = role.clone(role_id: '<ROLE-ID>', name: 'Role Clone')

puts JSON.pretty_generate(response)