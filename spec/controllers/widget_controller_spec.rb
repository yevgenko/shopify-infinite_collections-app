require 'spec_helper'

describe WidgetController do
  describe "GET 'index'" do
    context "with valid attributes" do
      let(:shop) { FactoryGirl.build(:shop) }

      before do
        Shop.stub(:find_by_url!).and_return(shop)
      end

      it "returns http success" do
        get 'index', :format => 'js'
        response.should be_success
      end

      it "assigns the requested shop as @shop" do
        get 'index', :format => 'js'
        assigns(:shop).should eq(shop)
      end
    end

    context "with invalid or missed attributes" do
      it "raises not found error" do
        expect{
          get 'index', :format => 'js'
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
