# List all server appliances on your account
appliance = OneAndOne::ServerAppliance.new()

response = appliance.list

puts JSON.pretty_generate(response)



# Returns information about an appliance
appliance = OneAndOne::ServerAppliance.new()

response = appliance.get(appliance_id: '<APPLIANCE-ID>')

puts JSON.pretty_generate(response)