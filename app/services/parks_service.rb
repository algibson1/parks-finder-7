class ParksService
  def connection 
    Faraday.new("https://developer.nps.gov/api/v1") do |f|
      f.params[:api_key] = Rails.application.credentials.national_parks_key[:key]
    end
  end

  def state_search(state_code)
    response = connection.get("parks?stateCode=#{state_code}")
    # For those who did not make it to the study hall session:
    # We all spent an hour struggling with this method
    # The problem was that our url above was written as:
    # "/parks?stateCode=#{state_code}"
    # as in.... that one single / in the front was breaking it
    # The error it returned looked like:
    #      JSON::ParserError:
    #           unexpected token at '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
    #           <html><head>
    #           <title>404 Not Found</title>
    #           </head><body>
    #           <h1>Not Found</h1>
    #           <p>The requested URL /parks was not found on this server.</p>
    #           </body></html>
    # So... if you're ever struggling with your connection not working...
    # Check for a / in front of your url!!!!
    JSON.parse(response.body, symbolize_names: true)
  end
end