require 'rails_helper'

RSpec.describe "Features", type: :request do
  describe "GET /features" do
    it "should get features" do
      trip = create(:feature)
      delivery_params = "{\"data\":[{\"id\":1,\"type\":\"feature\",\"attributes\":{\"external_id\":\"nc74032311\",\"magnitude\":1.98,\"place\":\"8 km W of Cobb, CA\",\"time\":\"2024-04-10T10:05:57.000-04:00\",\"tsunami\":true,\"mag_type\":\"md\",\"title\":\"M 0.9 - 8 km W of Cobb, CA\",\"coordinates\":{\"longitude\":-122.8093338,\"latitude\":38.831501}},\"links\":{\"external_url\":\"https://earthquake.usgs.gov/earthquakes/eventpage/nc74032261\"}}]}"

      get "/features"

      expect(response.status).to eq(200)
      expect(response.body).to eq(delivery_params)
    end
  end
end
