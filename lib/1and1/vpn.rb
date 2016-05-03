module OneAndOne

  
  class Vpn

    
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
      path = OneAndOne.build_url('/vpns')

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


    def get(vpn_id: @id)

      # If user passed in vpn ID, reassign
      @id = vpn_id

      # Build URL
      path = OneAndOne.build_url("/vpns/#{@id}")

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


    def create(name: nil, description: nil, datacenter_id: nil)

      # Build POST body
      new_vpn = {
        'name' => name,
        'description' => description,
        'datacenter_id' => datacenter_id
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_vpn)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/vpns')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new vpn ID to Vpn instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def modify(vpn_id: @id, name: nil, description: nil)

      # If user passed in vpn ID, reassign
      @id = vpn_id

      # Build PUT body
      vpn_specs = {
        'name' => name,
        'description' => description
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(vpn_specs)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/vpns/#{@id}")

      # Perform Request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def delete(vpn_id: @id)

      # If user passed in vpn ID, reassign
      @id = vpn_id

      # Build URL
      path = OneAndOne.build_url("/vpns/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def download_config(vpn_id: @id)

      # If user passed in vpn ID, reassign
      @id = vpn_id

      # Build URL
      path = OneAndOne.build_url("/vpns/#{@id}/configuration_file")

      # Perform request
      response = @connection.request(:method => :get,
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


    def wait_for(timeout: 25, interval: 15)

      # Capture start time
      start = Time.now

      # Poll VPN and check initial state
      initial_response = get
      vpn_state = initial_response['state']

      # Keep polling the VPN's state until good
      until $good_states.include? vpn_state

        # Wait 15 seconds before polling again
        sleep interval

        # Check VPN state again
        current_response = get
        vpn_state = current_response['state']

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