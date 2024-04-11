require 'rails_helper'

RSpec.describe Feature, type: :model do
  let!(:feature) { create(:feature) }

  describe "validations" do
    it "is valid with attributes" do
      expect(feature).to be_valid
    end
  end

  describe "scope" do
    it "filter by magType" do
      expect(Feature.by_magType("md")).to include(feature)
    end
  end

  describe "methods" do
    it "should filter features" do
      features = Feature.filter_features({ page: "1", per_page: "3"})

      expect(features.count).to be(1)
    end
  end
end
