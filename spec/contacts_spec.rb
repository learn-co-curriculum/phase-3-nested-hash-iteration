require_relative 'spec_helper'
require_relative '../contacts'

describe "#remove_strawberry" do
  it "removes the strawberry ice cream from :favorite_ice_cream_flavors" do
    result = remove_strawberry(contacts)
    expect(result["Freddie Mercury"][:favorite_ice_cream_flavors]).not_to include("strawberry")
  end
end
