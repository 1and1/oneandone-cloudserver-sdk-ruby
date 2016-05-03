module OneAndOne


  class MonitoringCenter


    def initialize(test: false)

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
      path = OneAndOne.build_url('/monitoring_center')

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


    def get(server_id: nil, period: nil, start_date: nil, end_date: nil)

        # Build hash for query parameters
        keyword_args = {
          :period => period,
          :start_date => start_date,
          :end_date => end_date
        }

        # Clean out null query parameters
        params = OneAndOne.clean_hash(keyword_args)

        # Build URL
        path = OneAndOne.build_url("/monitoring_center/#{server_id}")

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


  end


end