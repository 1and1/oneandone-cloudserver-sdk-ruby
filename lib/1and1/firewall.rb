module OneAndOne


  class Firewall

    
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
      path = OneAndOne.build_url('/firewall_policies')

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


    def create(name: nil, description: nil, rules: nil)

      # Build POST body
      new_firewall = {
        'name' => name,
        'description' => description,
        'rules' => rules,
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_firewall)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/firewall_policies')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new firewall ID to Firewall instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(firewall_id: @id)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}")

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


    def modify(firewall_id: @id, name: nil, description: nil)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build PUT body
      new_firewall = {
        'name' => name,
        'description' => description
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(new_firewall)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}")

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


    def delete(firewall_id: @id)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ips(firewall_id: @id)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/server_ips")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ip(firewall_id: @id, ip_id: nil)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/server_ips/#{ip_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_ips(firewall_id: @id, ips: nil)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build POST body
      new_ips = {
        'server_ips' => ips
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_ips)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/server_ips")

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


    def rules(firewall_id: @id)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/rules")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def rule(firewall_id: @id, rule_id: nil)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/rules/#{rule_id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_rules(firewall_id: @id, rules: nil)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build POST body
      new_rules = {
        'rules' => rules
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_rules)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/rules")

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


    def remove_rule(firewall_id: @id, rule_id: nil)

      # If user passed in firewall ID, reassign
      @id = firewall_id

      # Build URL
      path = OneAndOne.build_url("/firewall_policies/#{@id}/rules/#{rule_id}")

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


    def wait_for(timeout: 25, interval: 1)

      # Capture start time
      start = Time.now

      # Poll firewall and check initial state
      initial_response = get
      firewall_state = initial_response['state']

      # Keep polling the firewall's state until good
      until $good_states.include? firewall_state

        # Wait 1 second before polling again
        sleep interval

        # Check firewall state again
        current_response = get
        firewall_state = current_response['state']

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