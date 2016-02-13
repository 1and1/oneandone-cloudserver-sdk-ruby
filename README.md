# 1&amp;1 Ruby SDK

The 1&amp;1 Ruby SDK is a Ruby gem used for interacting with the 1&amp;1 platform over the REST API.

This guide will show you how to programmatically use the 1&amp;1 library to perform common management tasks also available through the 1&amp;1 Control Panel.

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
  * [Installation](#installation)
  * [Authentication](#authentication)
- [Operations](#operations)
  - [Using the Module](#using-the-module)
  - [Creating a Server](#creating-a-server)
  - [Creating a Firewall Policy](#creating-a-firewall-policy)
  - [Creating a Load Balancer](#creating-a-load-balancer)
  - [Creating a Monitoring Policy](#creating-a-monitoring-policy)
  - [Updating Server Cores, Memory, and Disk](#updating-server-cores,-memory,-and-disk)
  - [Listing Servers, Images, Shared Storages, and More](#listing-servers,-images,-shared-storages,-and-more )
- [Example App](#example-app)


## Overview

The Ruby Client Library wraps the latest version of the 1&amp;1 REST API. All API operations are performed over SSL and authenticated using your 1&amp;1 API Token. The API can be accessed within an instance running in 1&amp;1 or directly over the Internet from any application that can send an HTTPS request and receive an HTTPS response.


## Getting Started

Before you begin you will need to have signed-up for a 1&amp;1 account. The credentials you setup during sign-up will be used to authenticate against the API.


### Installation

You can install the latest stable version using:

`$ gem install 1and1`


### Authentication

Connecting to 1&amp;1 is handled by first setting up your authentication.  Start your application by initializing the module with your API token.

```
require 'oneandone'

OneAndOne.start('<API-TOKEN>')
```


## Operations

### Using the Module

Official 1&amp;1 REST API Documentation: <a href='https://cloudpanel-api.1and1.com/documentation/v1/#' target='_blank'>https://cloudpanel-api.1and1.com/documentation/v1/#</a>

The following examples are meant to give you a general overview of some of the things you can do with the 1&amp;1 Ruby SDK.  For a detailed list of all methods and functionality, please visit the <a href='docs/reference.md'>reference.md</a> file.




### Creating a Server

```
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


### Creating a Firewall Policy

```
require 'oneandone'

OneAndOne.start('<API-TOKEN>') # Init module with API Key


# Instantiate Firewall Object
firewall = OneAndOne::Firewall.new

# Create Rules
rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
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

```
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

```
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
```
# Add Servers
server1 = '<SERVER-ID>'
server2 = '<SERVER-ID>'

servers = [server1, server2]

# Perform Request
response = monitoring_policy.add_servers(servers: servers)

puts JSON.pretty_generate(response)
```


### Updating Server Cores, Memory, and Disk

1&amp;1 allows users to dynamically update cores, memory, and disk independently of each other. This removes the restriction of needing to upgrade to the next size up to receive an increase in memory. You can now simply increase the instances memory keeping your costs in-line with your resource needs.

The following code illustrates how you can update cores and memory:
```
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
```
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
```
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
```



## Example App

This simple app creates a load balancer, firewall policy, and server.  It then creates a new IP for the server and adds the load balancer and firewall policy to that IP.

Use the `wait_for` method to chain together multiple actions that take some time to deploy.  See the <a href='docs/reference.md'>reference.md</a> file for a more detailed description of the `wait_for` method.

The source code for the Example App with some additional markup can be found <a href='examples/example_app.rb'>here</a>.
```
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

lb1 = load_balancer.create(name: 'Example App LB',
                           description: 'Example Desc',
                           health_check_test: 'TCP',
                           health_check_interval: 40,
                           persistence: true,
                           persistence_time: 1200,
                           method: 'ROUND_ROBIN',
                           rules: rules)

# Wait for load balancer to deploy
puts "Creating load balancer..."
load_balancer.wait_for



### Create firewall policy
firewall = OneAndOne::Firewall.new

rule1 = {
  'protocol' => 'TCP',
  'port_from' => 80,
  'port_to' => 80,
  'source' => '0.0.0.0'
}

rules = [rule1]

fp1 = firewall.create(name: 'Example App Firewall',
                      description: 'Example Desc',
                      rules: rules)

# Wait for firewall policy to deploy
puts "Creating firewall policy..."
firewall.wait_for



### Create a server
server = OneAndOne::Server.new

hdd1 = {
  'size' => 120,
  'is_main' => true
}

hdds = [hdd1]

server1 = server.create(name: 'Example App Server',
                        vcore: 1,
                        cores_per_processor: 1,
                        ram: 1,
                        appliance_id: '<IMAGE-ID>',
                        hdds: hdds)

# Wait for server to deploy
puts "Creating server..."
server.wait_for



### Add a new IP to the server
puts "Adding an IP to the server..."
response = server.add_ip
new_ip = response['ips'][1]['id']



### Add the load balancer to the new IP
response = server.add_load_balancer(ip_id: new_ip,
                                    load_balancer_id: load_balancer.id)

# Wait for load balancer to be added
puts "Adding load balancer to new server IP..."
server.wait_for



### Add the firewall policy to the new IP
response = server.add_firewall(ip_id: new_ip,
                               firewall_id: firewall.id)

# Wait for firewall policy to be added
puts "Adding firewall policy to new server IP..."
server.wait_for
puts "Everything looks good!"



### Cleanup
puts "Let's clean up the mess we just made."

puts "Deleting server..."
response = server.delete
puts "Success!"

puts "Deleting load balancer..."
response = load_balancer.delete
puts "Success!"

puts "Deleting firewall policy..."
response = firewall.delete
puts "Success!"

puts "All done!"
```
