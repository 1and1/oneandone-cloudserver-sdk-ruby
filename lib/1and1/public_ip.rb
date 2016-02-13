module OneAndOne


  class PublicIP

    
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
      path = OneAndOne.build_url('/public_ips')

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header,
        :query => params)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

    end


    def create(reverse_dns: nil, type: nil)

      # Build POST body
      new_ip = {
        'reverse_dns' => reverse_dns,
        'type' => type
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_ip)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url('/public_ips')

      # Perform request
      response = @connection.request(:method => :post,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

      # Save new IP ID to PublicIP instance
      @id = json['id']
      @specs = json

      # If all good, return JSON
      json

    end


    def get(ip_id: @id)

      # If user passed in IP ID, reassign
      @id = ip_id

      # Build URL
      path = OneAndOne.build_url("/public_ips/#{@id}")

      # Perform request
      response = @connection.request(:method => :get,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

    end


    def modify(ip_id: @id, reverse_dns: nil)

      # If user passed in shared_storage ID, reassign
      @id = ip_id

      # Build PUT body
      new_ip = {
        'reverse_dns' => reverse_dns
      }

      # Clean out null keys in POST body
      body = OneAndOne.clean_hash(new_ip)

      # Stringify the POST body
      string_body = body.to_json

      # Build URL
      path = OneAndOne.build_url("/public_ips/#{@id}")

      # Perform request
      response = @connection.request(:method => :put,
        :path => path,
        :headers => $header,
        :body => string_body)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

    end


    def delete(ip_id: @id)

      # If user passed in IP ID, reassign
      @id = ip_id

      # Build URL
      path = OneAndOne.build_url("/public_ips/#{@id}")

      # Perform request
      response = @connection.request(:method => :delete,
        :path => path,
        :headers => $header)

      # Check response status
      OneAndOne.check_response(response.body, response.status)

      #JSON-ify the response string
      json = JSON.parse(response.body)

    end


  end


end