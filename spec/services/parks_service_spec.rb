require "rails_helper"

RSpec.describe ParksService, :vcr do
  it "connects to Parks api" do
    service = ParksService.new 
    expect(service.connection).to be_a(Faraday::Connection)
  end

  it "returns parks by state" do
    service = ParksService.new
    response = service.state_search("TN")
    expect(response).to be_a(Hash)
    expect(response).to have_key(:total)
    expect(response).to have_key(:limit)
    expect(response).to have_key(:start)
    expect(response).to have_key(:data)
  end
end