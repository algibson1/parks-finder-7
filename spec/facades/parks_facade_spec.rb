require "rails_helper"

RSpec.describe ParksFacade, :vcr do
  it "has no park info upon initialization" do
    facade = ParksFacade.new
    expect(facade.parks_by_state).to eq({})
  end

  it "can add parks" do
    facade = ParksFacade.new 
    tn_parks = facade.get_parks("TN")

    expect(tn_parks).to be_an(Array)
    expect(tn_parks).to all be_a(Park)
    expect(tn_parks.count).to eq(15)
    expect(facade.parks_by_state).to eq({"TN" => tn_parks})

    co_parks = facade.get_parks("CO")
    expect(facade.parks_by_state).to eq({"TN" => tn_parks, "CO" => co_parks})

    # if the parks were NOT memoized the first time get_parks("TN") was called,
    # then it would generate new poros each time it was called
    # and those new poros would be considered != to the original ones
    # Therefore if this test below passes,
    # We know that get_parks is successfully saving and returning data
    # without calling the service a second time
    expect(facade.get_parks("TN")).to eq(tn_parks)
  end
end