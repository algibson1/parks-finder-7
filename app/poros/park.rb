class Park
  attr_reader :name,
              :description,
              :directions,
              :standard_hours
  def initialize(data)
    @name = data[:fullName]
    @description = data[:description]
    @directions = data[:directionsInfo]
    @standard_hours = operating_hours(data[:operatingHours])
  end

  def operating_hours(data)
    return data if data.empty?
    data[0][:standardHours]
  end
  # This issue will never show up for the Tennessee parks in the challenge-
  # But when I ran a different search
  # I ended up with one result that had an empty array
  # Inside the operatingHours key
  # Which broke my original solution in the initialize which said
  # @standard_hours = data[:operatingHours][0][:standardHours]
  # Thus I added this second method to first check whether the hours existed
end