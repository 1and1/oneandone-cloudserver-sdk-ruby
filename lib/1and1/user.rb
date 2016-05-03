module OneAndOne


  class User

    
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
      path = OneAndOne.build_url('/users')

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


    def create(name: nil, description: nil, password: nil, email: nil)

      # Build POST body
      new_user = {
        'name' => name,
        'description' => description,
        'password' => password,
        'email' => email
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_user)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/users')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new user ID to User instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(user_id: @id)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def modify(user_id: @id, description: nil, password: nil, email: nil,
      state: nil)

      # If user passed in user ID, reassign
      @id = user_id

      # Build PUT body
      new_user = {
        'description' => description,
        'password' => password,
        'email' => email,
        'state' => state
      }

      # Clean out null keys in PUT body
      body = OneAndOne.clean_hash(new_user)

      # Stringify the PUT body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}")

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


    def delete(user_id: @id)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def api(user_id: @id)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def enable_api(user_id: @id, active: nil)

      # If user passed in user ID, reassign
      @id = user_id

      # Build PUT body
      new_api = {
        'active' => active
      }

      # Stringify the PUT body
      string_body = new_api.to_json

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api")

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


    def api_key(user_id: @id)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api/key")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def change_key(user_id: @id)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api/key")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def ips(user_id: @id)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api/ips")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def add_ips(user_id: @id, ips: nil)

      # If user passed in user ID, reassign
      @id = user_id

      # Build POST body
      new_ips = {
        'ips' => ips
      }

      # Stringify the POST body
      string_body = new_ips.to_json

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api/ips")

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


    def remove_ip(user_id: @id, ip: nil)

      # If user passed in user ID, reassign
      @id = user_id

      # Build URL
      path = OneAndOne.build_url("/users/#{@id}/api/ips/#{ip}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


    def permissions

      # Build URL
      path = OneAndOne.build_url('/users/current_user_permissions')

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      JSON.parse(response.body)

    end


  end


end