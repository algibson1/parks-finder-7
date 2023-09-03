class ParksController < ApplicationController
  def index
    @parks = facade.get_parks(params[:state])
  end

  private
  def facade 
    @_facade ||= ParksFacade.new
  end
  # facade must be memoized for the way I am using it--
  # If you call ParksFacade.new in the index action,
  # You would generate a new Facade (with no memoized data) every time the index page is refreshed
  # So you'd be calling the API every time you refresh the page
end