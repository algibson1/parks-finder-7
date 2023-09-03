class ParksFacade
  attr_reader :parks_by_state
  def initialize
    @parks_by_state = {}
    # initializing with an empty hash
  end

  def get_parks(state)
    @parks_by_state[state] ||= generate_parks(state)
    # The first time we call get_parks for "TN"
    # It will look at the hash @parks_by_state, in the key "TN"
    # If the key is nonexistent (which it is), the value returns nil
    # Because of the || (or) operator, the program will skip over the nil value
    # and instead go to generate_parks
    # then because of the = operator,
    # It will be equivalent to assigning a new key value pair to a hash
    # in this case, @parks_by_state["TN"] = array_of_tn_parks

    # Now, the SECOND time we call get_parks for "TN"
    # It will check the @parks_by_state hash, for the key "TN"
    # And it WILL find data there, from the first time we called the method
    # And it will return THAT data instead of calling the API again


    # In reality, if the API updates,
    # This kind of caching means our app will not show any of the new info right away
    # Because it will continue to use pre-saved data
    # Until we do something to reset the app so that @parks_by_state is empty again
    # This could be a good thing, though--
    # Your app will continue to work until you get a chance to update it
    # according to whatever was changed on the API 

    # There's probably also a way to set intervals for the app memory to expire
  end
  
  private 
  def generate_parks(state)
    service.state_search(state)[:data].map do |park_data|
      Park.new(park_data)
    end
  end
  
  def service 
    @_service ||= ParksService.new
  end
  # Not actually sure if memoizing the service is necessary
  # I mainly did it because I figured we only need one service
  # And initiating a new one for each state would be unneccessary 
  # But I don't think this actually saves any time or memory
  # Since the service itself won't call the API until we tell it to
  # And it doesn't store any data itself like the Facade does
end