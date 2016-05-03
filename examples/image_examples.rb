# List all images on your account
image = OneAndOne::Image.new()

response = image.list

puts JSON.pretty_generate(response)



# Create a new image
image = OneAndOne::Image.new()

response = image.create(server_id: '<SERVER-ID>', name: 'Example Image',
  frequency: 'ONCE', num_images: 1)

puts JSON.pretty_generate(response)

## Wait for image to deploy before performing other actions ## 
puts "\nCreating image, please wait..."
image.wait_for



# Retrieve the current specs for an image
image = OneAndOne::Image.new()

response = image.get(image_id: '<IMAGE-ID>')

puts JSON.pretty_generate(response)



# Modify an image
image = OneAndOne::Image.new()

response = image.modify(image_id: '<IMAGE-ID>', name: 'New Name')

puts JSON.pretty_generate(response)



# Delete the new image
image = OneAndOne::Image.new()

response = image.delete(image_id: '<IMAGE-ID>')

puts JSON.pretty_generate(response)

