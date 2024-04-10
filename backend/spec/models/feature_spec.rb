require 'rails_helper'

RSpec.describe Feature, type: :model do
  let!(:feature) { create(:feature) }

  describe "validations" do
    it "is valid with attributes" do
      expect(feature).to be_valid
    end
  end
end
