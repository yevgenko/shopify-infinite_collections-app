require 'spec_helper'

describe Shop do
  let(:shop) { FactoryGirl.create(:shop) }

  describe "#url" do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
    it "shouldn't be attr_accessible" do
      expect {
        shop.update_attributes url: 'demo2.myshopify.com'
      }.to raise_error(
        ActiveModel::MassAssignmentSecurity::Error
      )
    end
  end
end
