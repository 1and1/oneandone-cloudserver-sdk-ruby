require_relative 'oneandone'

OneAndOne.start('<API-TOKEN>')




# List all DVD's on your account
dvd = OneAndOne::Dvd.new()

response = dvd.list

puts JSON.pretty_generate(response)



# Returns information about a DVD
dvd = OneAndOne::Dvd.new()

response = dvd.get(dvd_id: '<DVD-ID>')

puts JSON.pretty_generate(response)