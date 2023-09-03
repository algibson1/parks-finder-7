require "rails_helper"

RSpec.describe Park do
  it "has a name, description, directions, state, and hours" do
    park = Park.new({
      description: "A random description", 
      fullName: "A National Park", 
      directionsInfo: "Some directions to the park", 
      operatingHours: [{
        standardHours: {
          wednesday: "9:00AM - 4:00PM",
          monday: "9:00AM - 4:00PM",
          thursday: "9:00AM - 4:00PM",
          sunday: "9:00AM - 4:00PM",
          tuesday: "9:00AM - 4:00PM",
          friday: "9:00AM - 4:00PM",
          saturday: "9:00AM - 4:00PM"
        }
       }]
      })

    expect(park.name).to eq("A National Park")
    expect(park.description).to eq("A random description")
    expect(park.directions).to eq("Some directions to the park")
    expect(park.standard_hours).to eq({
      wednesday: "9:00AM - 4:00PM",
      monday: "9:00AM - 4:00PM",
      thursday: "9:00AM - 4:00PM",
      sunday: "9:00AM - 4:00PM",
      tuesday: "9:00AM - 4:00PM",
      friday: "9:00AM - 4:00PM",
      saturday: "9:00AM - 4:00PM"
    })
  end
end