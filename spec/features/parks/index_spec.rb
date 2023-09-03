require "rails_helper"

RSpec.describe "Parks index page" do
  it "can search for parks by state", :vcr do
    visit root_path

    # As a user,
    # When I select "Tennessee" from the form,
    select "Tennessee", from: :state
    # And click on "Find Parks",
    click_button "Find Parks"

    expect(current_path).to eq("/parks")
          # Needed to create/add the following:
            # Route to a ParksController
            # ParksController, with index action
                  # Controller calls on a facade
                      # Facade calls on a service and a Park poro
            # View for ParksController Index 

          #( No Models Created- Using an API database, not our own )
    
    parks = ParksFacade.new.get_parks("TN")
    # I see the total of parks found,
    expect(page).to have_content("Total Parks: 15")
    # And for each park I see:
    parks.each do |park|
      # - full name of the park
      expect(page).to have_content(park.name)
      # - description
      expect(page).to have_content(park.description)
      # - direction info
      expect(page).to have_content(park.directions)
    end
    
    # - standard hours for operation
    expect(page).to have_content("Standard Hours:", count: 15)
  end
end
