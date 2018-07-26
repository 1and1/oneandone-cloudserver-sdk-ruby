# 1&amp;1 Ruby SDK

The 1&amp;1 Ruby SDK is a Ruby gem used for interacting with the 1&amp;1 platform over the REST API.

This guide will show you how to programmatically use the 1&amp;1 library to perform common management tasks also available through the 1&amp;1 Control Panel. For more information on the 1&amp;1 Ruby SDK see the [1&1 Community Portal](https://www.1and1.com/cloud-community/).

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
  * [Installation](#installation)
  * [Authentication](#authentication)
- [Operations](#operations)
  - [Using the Module](#using-the-module)
  - [Creating a Server](#creating-a-server)
  - [Creating a Server with SSH Key Access](#creating-a-server-with-ssh-key-access)
  - [Creating a Firewall Policy](#creating-a-firewall-policy)
  - [Creating a Load Balancer](#creating-a-load-balancer)
  - [Creating a Monitoring Policy](#creating-a-monitoring-policy)
  - [Creating a Block Storage](#creating-a-block-storage)
  - [Creating an SSH Key](#creating-an-ssh-key)
  - [Updating Server Cores, Memory, and Disk](#updating-server-cores,-memory,-and-disk)
  - [Listing Servers, Images, Shared Storages, and More](#listing-servers,-images,-shared-storages,-and-more )
- [Example App](#example-app)


## Overview

The Ruby Client Library wraps the latest version of the 1&amp;1 REST API. All API operations are performed over SSL and authenticated using your 1&amp;1 API Token. The API can be accessed within an instance running in 1&amp;1 or directly over the Internet from any application that can send an HTTPS request and receive an HTTPS response.

For more information on the 1&1 Cloud Server SDK for Ruby, visit the [Community Portal](https://www.1and1.com/cloud-community/).


## Getting Started

Before you begin you will need to have signed-up for a 1&amp;1 account. The credentials you setup during sign-up will be used to authenticate against the API.


### Installation

You can install the latest stable version using:

```bash
$ gem install 1and1
```


### Authentication

Connecting to 1&amp;1 is handled by first setting up your authentication.  Start your application by initializing the module with your API token.

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>')
```


## Operations

### Using the Module

Official 1&amp;1 REST API Documentation: <a href='https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html' target='_blank'>https://cloudpanel-api.1and1.com/documentation/1and1/v1/en/documentation.html</a>

The following examples are meant to give you a general overview of some of the things you can do with the 1&amp;1 Ruby SDK.  For a detailed list of all methods and functionality, please visit the <a href='docs/reference.md'>reference.md</a> file.




### Creating a Server

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Server Object
server = OneAndOne::Server.new

# Create HDD's
hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

# Perform Request
response = server.create(name: 'Example Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds)

puts JSON.pretty_generate(response)
```


### Creating a Server with SSH Key Access

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Server Object
server = OneAndOne::Server.new

# Create HDD's
hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

# Assign your public key to a variable
pub_key = '<PUB-KEY>'

# Perform Request
response = server.create(name: 'Example Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds,
                         rsa_key: pub_key)

puts JSON.pretty_generate(response)
```
**Note:** You may then SSH into your server by executing the following command in terminal 

`ssh –i <path_to_private_key_file> root@SERVER_IP`


### Creating a Firewall Policy

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Firewall Object
firewall = OneAndOne::Firewall.new

# Create Rules
rule1 = {
  'protocol' => 'TCP',
  'port' => 80,
  'action' => 'allow',
  'source' => '0.0.0.0'
}

rules = [rule1]

# Perform Request
response = firewall.create(name: 'Test Firewall',
                           description: 'Example Desc',
                           rules: rules)

puts JSON.pretty_generate(response)
```


### Creating a Load Balancer

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Load Balancer Object
load_balancer = OneAndOne::LoadBalancer.new

# Create Rules
rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

# Perform Request
response = load_balancer.create(name: 'Test LB',
                                description: 'Example Desc',
                                health_check_test: 'TCP',
                                health_check_interval: 40,
                                persistence: true,
                                persistence_time: 1200,
                                method: 'ROUND_ROBIN',
                                rules: rules)

puts JSON.pretty_generate(response)
```


### Creating a Monitoring Policy

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Monitoring Policy Object
monitoring_policy = OneAndOne::MonitoringPolicy.new

# Create Threshold Limits
thresholds = {
  'cpu' => {
    'warning' => {
      'value' => 90,
      'alert' => false
    },
    'critical' => {
      'value' => 95,
      'alert' => false
    }
  },
  'ram' => {
    'warning' => {
      'value' => 90,
      'alert' => false
    },
    'critical' => {
      'value' => 95,
      'alert' => false
    }
  },
  'disk' => {
    'warning' => {
      'value' => 90,
      'alert' => false
    },
    'critical' => {
      'value' => 95,
      'alert' => false
    }
  },
  'transfer' => {
    'warning' => {
      'value' => 1000,
      'alert' => false
    },
    'critical' => {
      'value' => 2000,
      'alert' => false
    }
  },
  'internal_ping' => {
    'warning' => {
      'value' => 50,
      'alert' => false
    },
    'critical' => {
      'value' => 100,
      'alert' => false
    }
  }
}

# Create Ports
port1 = {
  'protocol' => 'TCP',
  'port' => 80,
  'alert_if' => 'NOT_RESPONDING',
  'email_notification' => true
}

ports = [port1]

# Create Processes
process1 = {
  'process' => 'test',
  'alert_if' => 'NOT_RUNNING',
  'email_notification' => true
}

processes = [process1]

# Perform Request
response = monitoring_policy.create(name: 'Test Monitoring Policy',
                                    email: 'test@example.com',
                                    agent: true,
                                    thresholds: thresholds,
                                    ports: ports,
                                    processes: processes)

puts JSON.pretty_generate(response)
```

Then, add a server or two:
```ruby
# Add Servers
server1 = '<SERVER-ID>'
server2 = '<SERVER-ID>'

servers = [server1, server2]

# Perform Request
response = monitoring_policy.add_servers(servers: servers)

puts JSON.pretty_generate(response)
```


### Creating an SSH Key

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate SshKey Object
ssh_key = OneAndOne::SshKey.new

ssh_key.create(name: 'Test SSH Key',
               description: 'Test Description',
               public_key: '<PUBLIC-KEY>')

# The created ssh key can now be used when creating a server
# Instantiate Server Object
server = OneAndOne::Server.new

# Create HDD's
hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

# Perform Request
response = server.create(name: 'Example rssh Server',
                         vcore: 1,
                         cores_per_processor: 1,
                         ram: 1,
                         appliance_id: '<IMAGE-ID>',
                         hdds: hdds,
                         public_key: ssh_key.id)

puts JSON.pretty_generate(response)
```


### Creating a Block Storage

```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Block Storage Object
block_storage = OneAndOne::BlockStorage.new

response = block_storage.create(name: 'My block storage',
                                description: 'My block storage description',
                                size: 20,
                                datacenter_id: '<DATACENTER-ID>',
                                server_id: '<SERVER-ID')

puts JSON.pretty_generate(response)
```


### Updating Server Cores, Memory, and Disk

1&amp;1 allows users to dynamically update cores, memory, and disk independently of each other. This removes the restriction of needing to upgrade to the next size up to receive an increase in memory. You can now simply increase the instances memory keeping your costs in-line with your resource needs.

The following code illustrates how you can update cores and memory:
```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Server Object
server = OneAndOne::Server.new

# Perform Request
response = server.modify_hardware(server_id: '<SERVER-ID>',
                                  vcore: 2,
                                  ram: 6)

puts JSON.pretty_generate(response)
```

This is how you would update a server disk's size:
```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Server Object
server = OneAndOne::Server.new

# Perform Request
response = server.modify_hdd(server_id: '<SERVER-ID>',
                             hdd_id: '<HDD-ID>',
                             size: 140)

puts JSON.pretty_generate(response)
```


### Listing Servers, Images, Shared Storages, and More

Generating a list of resources is fairly straight forward.  Every class in the module comes equipped with a `list` method.  You may pass optional query parameters to help filter your results.  By default, these parameters are all set to `nil`.

**Here are the parameters available to you:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-`page` (integer): Allows to the use of pagination. Indicate which page to start on.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-`per_page` (integer): Number of items per page.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-`sort` (string): `sort='name'` retrieves a list of elements sorted alphabetically. `sort='creation_date'` retrieves a list of elements sorted by their creation date in descending order.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-`q` (string): `q` is for query.  Use this parameter to return only the items that match your search query.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-`fields` (string): Returns only the parameters requested. (i.e. fields='id, name, description, hardware.ram')


**Here are a few examples of how you would list resources:**
```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# List all servers on your account
server = OneAndOne::Server.new

response = server.list


# List all servers whose name contains "My"
server = OneAndOne::Server.new

response = server.list(q: 'My')


# List all images on your account
image = OneAndOne::Image.new

response = image.list


# List all block storages on your account
block_storage = OneAndOne::BlockStorage.new

response = block_storage.list
```



## Example App

This simple app creates a load balancer, firewall policy, and server.  It then adds the load balancer and firewall policy to the server's initial IP address.  You can access a server's initial IP by using the `first_ip` attribute on the Server class object, as seen in the example below.

The source code for the Example App can be found <a href='examples/example_app.rb'>here</a>.
```ruby
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API key



### Create load balancer
load_balancer = OneAndOne::LoadBalancer.new

rule1 = {
  'protocol' => 'TCP',
  'port_balancer' => 80,
  'port_server' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

lb1 = load_balancer.create(name: 'Example App LB', description: 'Example Desc',
  health_check_test: 'TCP', health_check_interval: 40, persistence: true,
  persistence_time: 1200, method: 'ROUND_ROBIN', rules: rules)

# Wait for load balancer to deploy
puts "\nCreating load balancer...\n"
puts load_balancer.wait_for



### Create firewall policy
firewall = OneAndOne::Firewall.new

rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

fp1 = firewall.create(name: 'Example App Firewall', description: 'Example Desc',
  rules: rules)

# Wait for firewall policy to deploy
puts "\nCreating firewall policy...\n"
puts firewall.wait_for



### Create a server
server = OneAndOne::Server.new

server1 = server.create(name: 'Example App Server',
  fixed_instance_id: '65929629F35BBFBA63022008F773F3EB',
  appliance_id: '6C902E5899CC6F7ED18595EBEB542EE1',
  datacenter_id: '5091F6D8CBFEF9C26ACE957C652D5D49')

# Wait for server to deploy
puts "\nCreating server...\n"
puts server.wait_for



### Add the load balancer to the server's initial IP
response = server.add_load_balancer(ip_id: server.first_ip['id'],
  load_balancer_id: load_balancer.id)

# Wait for load balancer to be added
puts "\nAdding load balancer to server IP...\n"
puts server.wait_for



### Add the firewall policy to the server's initial IP
response = server.add_firewall(ip_id: server.first_ip['id'],
  firewall_id: firewall.id)

# Wait for firewall policy to be added
puts "\nAdding firewall policy to server IP...\n"
puts server.wait_for
puts "\nEverything looks good!"



### Cleanup
puts "\nLet's clean up the mess we just made.\n"

puts "\nDeleting server...\n"
server.delete
puts "Success!\n"

puts "\nDeleting firewall policy...\n"
firewall.delete
puts "Success!\n"

puts "\nDeleting load balancer...\n"
load_balancer.delete
puts "Success!\n"

puts "\nAll done!\n"
```
