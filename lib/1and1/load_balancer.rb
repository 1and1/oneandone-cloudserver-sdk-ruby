module OneAndOne


  class LoadBalancer

    
    attr_accessor :id
    attr_accessor :specs


    def initialize(test: false)
      @id = nil
      @specs = nil

      # Check if hitting mock api or live api
      if test
        @connection = Excon.new($base_url, :mock => true)
      else
        @connection = Excon.new($base_url)
      end

    end


    def list(page: nil, per_page: nil, sort: nil, q: nil, fields: nil)

      # Build hash for query parameters
      keyword_args = {
        :page => page,
        :per_page => per_page,
        :sort => sort,
        :q => q,
        :fields => fields
      }

      # Clean out null query parameters
      params = OneAndOne.clean_hash(keyword_args)

      # Build URL
      path = OneAndOne.build_url('/load_balancers')

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header,
        :query => params)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def create(name: nil, description: nil, health_check_test: nil,
      health_check_interval: nil, persistence: nil, persistence_time: nil,
      method: nil, rules: nil, health_check_path: nil, health_check_parse: nil,
      datacenter_id: nil)

      # Build POST body
      new_load_balancer = {
        'name' => name,
        'description' => description,
        'health_check_test' => health_check_test,
        'health_check_interval' => health_check_interval,
        'persistence' => persistence,
        'persistence_time' => persistence_time,
        'method' => method,
        'rules' => rules,
        'health_check_path' => health_check_path,
        'health_check_parse' => health_check_parse,
        'datacenter_id' => datacenter_id
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_load_balancer)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/load_balancers')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new load balancer ID to LoadBalancer instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(load_balancer_id: @id)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Reload specs attribute
      @specs = json

      # If all good, return JSON
      json

    end


    def modify(load_balancer_id: @id, name: nil, description: nil,
      health_check_test: nil, health_check_interval: nil, persistence: nil,
      persistence_time: nil, method: nil, health_check_path: nil,
      health_check_parse: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build PUT body
      new_load_balancer = {
        'name' => name,
        'description' => description,
        'health_check_test' => health_check_test,
        'health_check_interval' => health_check_interval,
        'persistence' => persistence,
        'persistence_time' => persistence_time,
        'method' => method,
        'health_check_path' => health_check_path,
        'health_check_parse' => health_check_parse
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(new_load_balancer)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def delete(load_balancer_id: @id)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ips(load_balancer_id: @id)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/server_ips")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ip(load_balancer_id: @id, ip_id: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/server_ips/#{ip_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_ip(load_balancer_id: @id, ip_id: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/server_ips/#{ip_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_ips(load_balancer_id: @id, ips: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build POST body
      new_ips = {
        'server_ips' => ips
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_ips)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/server_ips")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def rules(load_balancer_id: @id)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/rules")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def rule(load_balancer_id: @id, rule_id: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/rules/#{rule_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_rules(load_balancer_id: @id, rules: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build POST body
      new_rules = {
        'rules' => rules
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_rules)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/rules")

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def remove_rule(load_balancer_id: @id, rule_id: nil)

      # If user passed in load balancer ID, reassign
      @id = load_balancer_id

      # Build URL
      path = OneAndOne.build_url("/load_balancers/#{@id}/rules/#{rule_id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def reload

      # This reload fx is just a wrapper for the get fx
      get

    end


    def wait_for(timeout: 25, interval: 5)

      # Capture start time
      start = Time.now

      # Poll load balancer and check initial state
      initial_response = get
      load_balancer_state = initial_response['state']

      # Keep polling the load balancer's state until good
      until $good_states.include? load_balancer_state

        # Wait 5 seconds before polling again
        sleep interval

        # Check load balancer state again
        current_response = get
        load_balancer_state = current_response['state']

        # Calculate current duration and check for timeout
        duration = (Time.now - start) / 60
        if duration > timeout
          puts "The operation timed out after #{timeout} minutes.\n"
          return
        end

      end

      # Return Duration
      {:duration => duration}

    end


  end


end